// swift-tools-version: 6.1
// This declares the minimum version of Swift required to build this package

import PackageDescription

/// Main package definition for the gRPC service project
///
/// This package defines a gRPC service with:
/// - An API library target containing the generated service definitions
/// - An executable target that implements and runs the service
let package = Package(
  name: "service",  // The name of the package
  platforms: [.macOS(.v15)],  // Requires macOS 15 (Sequoia) or later

  // Products define the libraries or executables produced by this package
  products: [
    .library(name: "api", targets: ["api"]),  // A library product that exports the protocol buffer generated code
  ],

  // External dependencies required by this package
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"), // For command-line argument parsing in the executable

    // Core gRPC dependencies for Swift
    .package(url: "https://github.com/grpc/grpc-swift-nio-transport.git", from: "1.0.3"),   // HTTP/2 transport
    .package(url: "https://github.com/grpc/grpc-swift-protobuf.git", from: "1.2.0"),        // Protocol Buffers support
    .package(url: "https://github.com/grpc/grpc-swift.git", from: "2.1.2"),                 // Core gRPC functionality

    // UI framework for potential admin interface
    .package(url: "https://github.com/twostraws/Ignite.git", branch: "main"),
  ],

  // The targets that make up this package
  targets: [
    // Main executable target that runs the gRPC service
    .executableTarget(
      name: "svc",  // The name of the compiled binary
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"), // Command line argument parsing

        // Core gRPC components for the server
        .product(name: "GRPCCore", package: "grpc-swift"),
        .product(name: "GRPCNIOTransportHTTP2", package: "grpc-swift-nio-transport"),

        // Local API target containing generated service definitions
        .target(name: "api"),
      ]
    ),

    // API target containing protocol buffer generated code
    .target(
      name: "api",
      dependencies: [
        .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"), // Protocol buffer serialization for gRPC
      ],
      plugins: [.plugin(name: "GRPCProtobufGenerator", package: "grpc-swift-protobuf")],  // Plugin to automatically generate Swift code from protobuf files
    ),
  ],
)
