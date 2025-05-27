// SPDX-License-Identifier: GPL-3.0

import GRPCCore
import api

/// A gRPC service implementation that provides greeting functionality
///
/// This struct implements the `Api_V1_Greeter.ServiceProtocol` to handle
/// greeting requests from clients. It provides a simple demonstration of
/// how to implement a gRPC service in Swift.
struct Greeter: Api_V1_Greeter.ServiceProtocol {
  /// Responds to a hello request with a personalized greeting message
  ///
  /// This method takes the name provided in the request and generates a
  /// personalized greeting. If no name is provided, it defaults to "stranger".
  ///
  /// - Parameters:
  ///   - request: The incoming request containing an optional name
  ///   - context: The server context for this gRPC call
  /// - Returns: A response containing the personalized greeting message
  /// - Throws: Any errors that occur during request processing
  func sayHello(
    request: ServerRequest<Api_V1_HelloRequest>,
    context: ServerContext
  ) async throws -> ServerResponse<Api_V1_HelloReply> {
    // Create a new reply message
    var reply = Api_V1_HelloReply()

    // Determine the recipient name, defaulting to "stranger" if empty
    let recipient = request.message.name.isEmpty ? "stranger" : request.message.name

    // Set the personalized greeting message
    reply.message = "Hello, \(recipient)"

    // Return the response with our reply message
    return ServerResponse(message: reply)
  }
}
