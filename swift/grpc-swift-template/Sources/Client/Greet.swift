// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import ArgumentParser
import AsyncHTTPClient
import Foundation
import NIOCore
import api

/// The `Greet` command-line tool.
///
/// This tool sends a request to a gRPC greeter server. It allows users to specify:
/// - The server address.
/// - The port to connect to.
/// - The name of the person to greet.
@main
struct Greet: AsyncParsableCommand {
  /// The command configuration, including a brief description of the tool.
  static let configuration = CommandConfiguration(abstract: "Send a request to the greeter server")

  /// The address of the server to connect to.
  @Option(help: "The address to connect to")
  var address = "127.0.0.1"

  /// The port on which the server is listening.
  @Option(help: "The port to listen on")
  var port = 8080

  /// The name of the person to greet.
  @Option(help: "The person to greet")
  var name = ""

  /// The main function that runs the command.
  ///
  /// This function:
  /// - (TODO) Sends a gRPC request to the greeter server.
  func run() async {
    // TODO: Implement the gRPC client to send a request to the greeter server.
  }
}
