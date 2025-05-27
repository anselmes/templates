// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

/// A utility structure for time-related operations.
///
/// The `Time` struct provides a collection of static methods for handling
/// time-related operations in the application, such as delays and timing functions.
public struct Time {}

// MARK: - Public API

public extension Time {
  /// Suspends the execution of the current thread for the specified duration.
  ///
  /// This function causes the current thread to sleep for at least the specified
  /// number of milliseconds. The actual sleep time might be slightly longer due
  /// to system scheduling and processing delays.
  ///
  /// - Parameter ms: The number of milliseconds to sleep.
  /// - Note: Internally uses the `k_msleep` system function.
  ///
  /// Example:
  /// ```
  /// Time.sleep(ms: 500) // Sleep for 500 milliseconds
  /// ```
  static func sleep(ms: Int32) { k_msleep(ms) }
}
