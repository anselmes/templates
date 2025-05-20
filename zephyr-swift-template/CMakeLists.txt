cmake_minimum_required(VERSION 3.29)

# Retrieve build configuration from environment variables
set(BOARD $ENV{ZEPHYR_BOARD})
set(BUILD_TARGET $ENV{ZEPHYR_BUILD_TARGET})
set(BUILD_TOOLCHAIN $ENV{ZEPHYR_BUILD_TOOLCHAIN})
set(CROSS_COMPILE $ENV{CROSS_COMPILE})
set(DTC_OVERLAY_FILE $ENV{ZEPHYR_BOARD_OVERLAY})
set(ZEPHYR_TOOLCHAIN_VARIANT $ENV{ZEPHYR_TOOLCHAIN_VARIANT})

# Configure Swift compiler settings
set(CMAKE_Swift_COMPILER_TARGET ${BUILD_TARGET})        # Set target triple for Swift compiler
set(CMAKE_Swift_COMPILATION_MODE wholemodule)           # Enable whole-module optimization (WMO) required by Embedded Swift
set(CMAKE_Swift_COMPILER_WORKS true)                    # Explicitly indicate Swift compiler is functional

# Find and include Zephyr RTOS package
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})

# Define the project with Swift language support
project(zephy-swift-template)
enable_language(Swift)

# Add C source file containing necessary stubs for Swift interoperability
target_sources(app PRIVATE src/Stubs.c)

# Create an OBJECT library for Swift main source file
# OBJECT library ensures the Swift main function is linked correctly
# Zephyr provides a default weak main definition, which would drop a STATIC library from linking
add_library(${PROJECT_NAME} OBJECT
  lib/Time.swift
  src/Main.swift
)

# Ensure syscall headers are generated before compiling Swift sources
# This is crucial as Swift code might depend on these generated headers.
add_dependencies(${PROJECT_NAME} syscall_list_h_target)

# Copy include directories from the C target (app) to the Swift target
# This makes Zephyr's and application's C headers available to Swift.
target_include_directories(${PROJECT_NAME} PRIVATE "$<TARGET_PROPERTY:app,INCLUDE_DIRECTORIES>")

# Link the Swift OBJECT library into the primary Zephyr application target
# This integrates the compiled Swift code into the final application.
target_link_libraries(app PRIVATE ${PROJECT_NAME})

# Add specific compile options for Swift language
target_compile_options(${PROJECT_NAME} PRIVATE
  # Enable experimental Embedded Swift features, necessary for targeting embedded platforms.
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-enable-experimental-feature Embedded>"

  # Parse Swift sources as a library, preventing the Swift compiler from expecting a main entry point (Zephyr provides it).
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-parse-as-library>"

  # Optimize Swift code for size, crucial for resource-constrained embedded systems.
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Osize>"


  # Emit LLVM IR as a single module. This can improve optimization opportunities.
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -enable-single-module-llvm-emission>"

  # Place each function in its own section in the object file.
  # This allows the linker to perform dead code stripping more effectively.
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -function-sections>"

  # Import the C bridging header, allowing Swift to call C functions and use C types.
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/include/BridgingHeader.h>"
)

# Post-build step: Remove the .swift_modhash section from the final binary
# The .swift_modhash section is used for incremental compilation but is not needed in the final embedded binary.
# Removing it reduces binary size and removes unnecessary metadata.
add_custom_command(TARGET app POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} --remove-section .swift_modhash $<TARGET_FILE:app> $<TARGET_FILE:app>
  COMMENT "Removing .swift_modhash section from final binary"
)
