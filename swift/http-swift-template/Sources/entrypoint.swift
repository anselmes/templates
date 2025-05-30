// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Vapor

// MARK: - Public API

/// Configures the application by setting up routes and other services.
///
/// - Parameter app: The `Application` instance to configure.
/// - Returns: A `Result` indicating success or failure during configuration.
public func configure(_ app: Application) async -> Result<Void, Error> {
  return routes(app)
}

// MARK: - Private API

/// Defines the routes for the application.
///
/// - Parameter app: The `Application` instance to add routes to.
/// - Returns: A `Result` indicating success or failure during route setup.
func routes(_ app: Application) -> Result<Void, Error> {
  app.get { req async in "It works!" }
  return .success(())
}

// MARK: - Main

/// The main entry point for the application.
@main
enum Entrypoint {
  /// Errors that can occur during application initialization.
  enum Error: Swift.Error {
    case applicationInitializationFailed
    case environmentDetectionFailed
  }

  /// The main function that initializes and runs the application.
  static func main() async {
    // Detect the environment (e.g., development, production).
    guard let env = try? Environment.detect() else {
      fatalError("Failed to detect the environment: \(Error.environmentDetectionFailed)")
    }

    // Create the application instance.
    guard let app = try? await Application.make(env) else {
      fatalError("Failed to initialize the application: \(Error.applicationInitializationFailed)")
    }

    // Configure the application.
    let result = await configure(app)
    if case .success = result {
      try? await app.execute()
    }

    // Shutdown the application gracefully.
    try? await app.asyncShutdown()
  }
}
