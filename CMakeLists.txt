cmake_minimum_required(VERSION 3.29)

# Retrieve build configuration from environment variables
set(BUILD_TARGET $ENV{ZEPHYR_BUILD_TARGET})
set(BUILD_TOOLCHAIN $ENV{ZEPHYR_BUILD_TOOLCHAIN})
set(BOARD $ENV{ZEPHYR_BOARD})
set(DTC_OVERLAY_FILE $ENV{ZEPHYR_BOARD_OVERLAY})

# Find and include Zephyr RTOS package
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})

# Configure Swift compiler settings
set(CMAKE_Swift_COMPILER_TARGET ${BUILD_TARGET})        # Set target triple for Swift compiler
set(CMAKE_Swift_COMPILATION_MODE wholemodule)           # Enable whole-module optimization (WMO) required by Embedded Swift
set(CMAKE_Swift_COMPILER_WORKS true)                    # Explicitly indicate Swift compiler is functional

# Define the project with Swift language support
project(zephyr-swift-template Swift)

# Set global Swift compiler flags for embedded Swift compilation
add_compile_options(
    "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-enable-experimental-feature Embedded>"          # Enable experimental Embedded Swift features
    "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -function-sections>"                  # Enable function sections for dead code stripping in ELF binaries
    "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -enable-single-module-llvm-emission>" # Emit LLVM IR as a single module for optimization
    "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-parse-as-library>"                              # Parse Swift sources as a library (no implicit main)
    "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Osize>"                                         # Optimize Swift code for binary size
    "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xcc -I${ZEPHYR_SDK_INSTALL_DIR}/${BUILD_TOOLCHAIN}/picolibc/include>"       # Include paths for picolibc headers
    "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/include/BridgingHeader.h>" # Import bridging header for Swift-C interoperability
)

# Add C source file containing necessary stubs for Swift interoperability
target_sources(app PRIVATE src/Stubs.c)

# Create an OBJECT library for Swift main source file
# OBJECT library ensures the Swift main function is linked correctly
# Zephyr provides a default weak main definition, which would drop a STATIC library from linking
add_library(${PROJECT_NAME}
  OBJECT
    src/Main.swift
    src/Time.swift
)

# Ensure syscall headers are generated before compiling Swift sources
add_dependencies(${PROJECT_NAME} syscall_list_h_target)

# Copy include directories from the C target (app) to the Swift target
target_include_directories(${PROJECT_NAME} PRIVATE "$<TARGET_PROPERTY:app,INCLUDE_DIRECTORIES>")

# Link the Swift OBJECT library into the primary Zephyr application target
target_link_libraries(app PRIVATE ${PROJECT_NAME})

# Post-build step: Remove the .swift_modhash section from the final binary
# This reduces binary size and removes unnecessary metadata
add_custom_command(TARGET app POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} --remove-section .swift_modhash $<TARGET_FILE:app> $<TARGET_FILE:app>
)
