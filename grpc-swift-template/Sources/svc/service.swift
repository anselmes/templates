// SPDX-License-Identifier: GPL-3.0

import ArgumentParser
import GRPCNIOTransportHTTP2

/// The main entry point for the gRPC Greeter service application
///
/// This struct defines the command-line interface for starting the service
/// and handles the lifecycle of the gRPC server. It uses ArgumentParser
/// to provide a clean command-line interface with options.
@main
struct GreaterService: AsyncParsableCommand {
  /// Command configuration details for the command-line interface
  static let configuration = CommandConfiguration(abstract: "Starts a greeter server.")

  /// The network port that the server will listen on
  ///
  /// This can be overridden by providing the --port option when starting the service
  @Option(help: "The port to listen on")
  var port: Int = 8080

  /// Runs the gRPC server until terminated
  ///
  /// This method:
  /// 1. Creates and configures a gRPC server
  /// 2. Registers the Greeter service
  /// 3. Starts the server in the background
  /// 4. Prints the active listening address
  ///
  /// - Throws: An error if the server fails to start or encounters problems
  func run() async throws {
    // Create a new gRPC server with HTTP/2 transport
    let server = GRPCServer(
      transport: .http2NIOPosix(
        address: .ipv4(host: "127.0.0.1", port: self.port),  // Listen on localhost at the specified port
        transportSecurity: .plaintext  // No TLS for simplicity (not secure for production)
      ),
      services: [Greeter()]  // Register our Greeter service implementation
    )

    // Start the server and wait for it to complete
    try await withThrowingDiscardingTaskGroup { group in
      // Launch the server in a background task
      group.addTask { try await server.serve() }

      // Once the server is ready, print the listening address
      if let address = try await server.listeningAddress {
        print("Greeter listening on \(address)")
      }
    }
  }
}
