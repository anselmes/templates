// swift-tools-version: 6.1
// This declares the minimum version of Swift required to build this package.

import PackageDescription

/// Main package definition for the gRPC service project.
///
/// This package defines a gRPC service with:
/// - An API library target containing the generated service definitions.
/// - An executable target that implements and runs the service.
/// - A client executable target for interacting with the service.
let package = Package(
  name: "grpc-swift-template",
  platforms: [.macOS(.v15)],

  // MARK: - Products

  // Products define the libraries or executables produced by this package.
  products: [
    // A library product that exports the protocol buffer generated code.
    .library(name: "api", targets: ["api"]),
  ],

  // MARK: - Dependencies

  // External dependencies required by this package.
  dependencies: [
    // For command-line argument parsing in the executable.
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),

    // Core gRPC dependencies for Swift.
    .package(url: "https://github.com/grpc/grpc-swift-nio-transport.git", from: "1.0.3"),   // HTTP/2 transport.
    .package(url: "https://github.com/grpc/grpc-swift-protobuf.git", from: "1.2.0"),        // Protocol Buffers support.
    .package(url: "https://github.com/grpc/grpc-swift.git", from: "2.1.2"),                 // Core gRPC functionality.
  ],

  // MARK: - Targets

  // The targets that make up this package.
  targets: [
    // Main executable target that runs the gRPC service.
    .executableTarget(
      name: "server",
      dependencies: [
        // Command-line argument parsing.
        .product(name: "ArgumentParser", package: "swift-argument-parser"),

        // Core gRPC components for the server.
        .product(name: "GRPCCore", package: "grpc-swift"),
        .product(name: "GRPCNIOTransportHTTP2", package: "grpc-swift-nio-transport"),

        // Local API target containing generated service definitions.
        .target(name: "api"),
      ]
    ),

    // Executable target for the gRPC client.
    .executableTarget(
      name: "client",
      dependencies: [
        // Command-line argument parsing.
        .product(name: "ArgumentParser", package: "swift-argument-parser"),

        // Local API target containing generated service definitions.
        .target(name: "api"),
      ],
    ),

    // API target containing protocol buffer generated code.
    .target(
      name: "api",
      dependencies: [
        // Protocol buffer serialization for gRPC.
        .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"),
      ],
      // Plugin to automatically generate Swift code from protobuf files.
      plugins: [.plugin(name: "GRPCProtobufGenerator", package: "grpc-swift-protobuf")],
    ),
  ],
)
