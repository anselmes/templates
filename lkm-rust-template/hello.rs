//! # Hello Kernel Module
//!
//! A simple Linux Kernel Module written in Rust that demonstrates
//! the basic structure of a kernel module with initialization and cleanup.
//!
//! This module prints a greeting message when loaded and a farewell
//! message when unloaded from the kernel.

// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-License-Identifier: GPL-2.0

// Don't use Rust standard library as we're in kernel space
#![no_std]
// Enable experimental features needed for kernel development
#![feature(allocator_api, global_asm)]

// Import kernel-specific types and macros
use kernel::prelude::*;

// Define the module metadata using the kernel-provided macro
module! {
  type: Hello,
  name: "hello",
  author: "Schubert Anselme <schubert@anselm.es",
  description: "Linux Kernel Module",
  license: "GPL v2",
  params: {}, // No parameters for this simple module
}

/// Represents our kernel module instance
///
/// This is an empty struct as we don't need to store any state,
/// but it's required to implement the KernelModule trait.
struct Hello;

impl KernelModule for Hello {
  /// Initializes the kernel module
  ///
  /// This function is called when the module is loaded into the kernel.
  /// It prints a greeting message and returns a new instance of our module.
  fn init() -> KernelResult<Self> {
    pr_info!("Hello world, from the kernel!\n");
    Ok(Hello {})
  }
}

impl Drop for Hello {
  /// Cleanup when the module is unloaded
  ///
  /// This function is called when the module is removed from the kernel.
  /// It prints a farewell message before the module is unloaded.
  fn drop(&mut self) {
    pr_info!("Goodbye!\n");
  }
}
