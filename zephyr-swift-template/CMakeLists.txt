# ==============================================================================
# HELLO PROJECT CMAKE CONFIGURATION
# ==============================================================================
# This CMake build file configures a Zephyr RTOS embedded project with Swift
# language support. It handles the integration between Swift compiler settings
# and Zephyr's build system for embedded development.
# ==============================================================================

cmake_minimum_required(VERSION 3.29)

# ==== Environment Configuration ====
# Retrieve build configuration from environment variables
set(BOARD $ENV{ZEPHYR_BOARD})                                 # Target board for the application
set(BUILD_TARGET $ENV{ZEPHYR_BUILD_TARGET})                   # Target triple (e.g., arm-none-eabi)
set(CROSS_COMPILE $ENV{CROSS_COMPILE})                        # Cross-compiler prefix
set(DTC_OVERLAY_FILE $ENV{ZEPHYR_BOARD_OVERLAY})              # Device Tree overlay file
set(SYSROOT_DIR $ENV{SYSROOT_DIR})                            # Sysroot directory for cross-compilation
set(ZEPHYR_TOOLCHAIN_VARIANT $ENV{ZEPHYR_TOOLCHAIN_VARIANT})  # Toolchain variant name

# ==== Zephyr Integration ====
# Find and include Zephyr RTOS package
# This initializes Zephyr's build system and makes its build targets available
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})

# ==== Swift Configuration ====
# Configure Swift compiler settings
set(CMAKE_Swift_COMPILER_TARGET ${BUILD_TARGET})        # Set target triple for Swift compiler
set(CMAKE_Swift_COMPILATION_MODE wholemodule)           # Enable whole-module optimization (WMO) required by Embedded Swift
set(CMAKE_Swift_COMPILER_WORKS true)                    # Explicitly indicate Swift compiler is functional

# Define the project with Swift language support
project(zephyr_swift_template)
enable_language(Swift)

# ==== Compiler Flags ====
# Set global Swift compiler flags
# These flags enable embedded development features and configure optimizations
add_compile_options(
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-enable-experimental-feature Embedded>"          # Enable Swift for embedded systems feature
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -function-sections>"                  # Place each function in its own section for better link-time optimization
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -enable-single-module-llvm-emission>" # Generate single LLVM module
)

# ==== Zephyr Definitions Propagation ====
# Add definitions from Zephyr to -Xcc flags
# This ensures Swift code has access to all Zephyr-defined macros
# get_target_property(ZEPHYR_DEFINES zephyr_interface INTERFACE_COMPILE_DEFINITIONS)
# if(ZEPHYR_DEFINES)
#   foreach(flag ${ZEPHYR_DEFINES})
#     # Ignore expressions like "$<SOMETHING>" which are CMake generator expressions
#     string(FIND "${flag}" "$<" start_of_expression)
#     if(NOT start_of_expression EQUAL -1)
#       continue()
#     endif()
#     add_compile_options("$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xcc -D${flag}>")
#   endforeach()
# endif()

# ==== C Support Files ====
# Add C stubs required for Swift/C interoperability
target_sources(app PRIVATE src/Stubs.c)  # Include C stubs for bridging Swift and C.

# ==== Swift Library Configuration ====
# Create an OBJECT library for Swift main source file
# OBJECT library ensures the Swift main function is linked correctly
# Zephyr provides a default weak main definition, which would drop a STATIC library from linking
add_library(${PROJECT_NAME} OBJECT
  src/Main.swift       # Main application entry point
  lib/Time.swift       # Time-related utilities
)

# ==== Build Dependencies ====
# Ensure syscall headers are generated before compiling Swift sources
# This is crucial as Swift code might depend on these generated headers.
add_dependencies(${PROJECT_NAME} syscall_list_h_target)

# ==== Swift Include Directories ====
# Set implicit include directories for Swift
# These directories are automatically included in the Swift compilation process
# This is necessary to ensure Swift can find all required headers.
# set(SWIFT_INCLUDES)
# foreach(dir ${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES})
#     string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-Xcc ")
#     string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-I${dir} ")
# endforeach()
# foreach(dir ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
#     string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-Xcc ")
#     string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-I${dir} ")
# endforeach()

# ==== Swift-Specific Compiler Options ====
# Add specific compile options for Swift language
target_compile_options(${PROJECT_NAME} PRIVATE
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-parse-as-library>"  # Process Swift files as libraries rather than executables
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Osize>"             # Optimize for binary size (important for embedded)
  # "$<$<COMPILE_LANGUAGE:Swift>:SHELL:${SWIFT_INCLUDES}>"  # Include directories for Swift compilation
  "$<$<COMPILE_LANGUAGE:Swift>:SHELL:-import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/include/BridgingHeader.h>" # Bridge to C APIs
)

# ==== Include Directories ====
# Copy include directories from the C target (app) to the Swift target
# This makes Zephyr's and application's C headers available to Swift.
target_include_directories(${PROJECT_NAME} PRIVATE "$<TARGET_PROPERTY:app,INCLUDE_DIRECTORIES>")

# ==== Linking ====
# Link the Swift OBJECT library into the primary Zephyr application target
# This integrates the compiled Swift code into the final application.
target_link_libraries(app PRIVATE ${PROJECT_NAME})

# ==== Post-Build Processing ====
# Post-build step: Remove the .swift_modhash section from the final binary
# The .swift_modhash section is used for incremental compilation but is not needed in the final embedded binary.
# Removing it reduces binary size and removes unnecessary metadata.
add_custom_command(TARGET app POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} --remove-section .swift_modhash $<TARGET_FILE:app> $<TARGET_FILE:app>
  COMMENT "Removing .swift_modhash section from final binary"
)
