// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// The main entry point for the web template application.
///
/// This struct initializes the site configuration and publishes the site using the Ignite framework.
@main
struct Entrypoint {
  /// The main asynchronous function that starts the application.
  ///
  /// This function:
  /// - Initializes the `Web` site configuration.
  /// - Attempts to publish the site using the Ignite framework.
  /// - Handles any errors that occur during publishing by terminating the application with a fatal error.
  static func main() async {
    // Initialize the site configuration.
    var web = Web()

    do {
      // Attempt to publish the site.
      try await web.publish()
    } catch {
      // Handle publishing errors by terminating the application with an error message.
      fatalError(error.localizedDescription)
    }
  }
}
