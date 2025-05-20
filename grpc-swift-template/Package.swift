// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "service",
  platforms: [.macOS(.v15)],
  products: [
    .library(name: "api", targets: ["api"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
    .package(url: "https://github.com/grpc/grpc-swift-nio-transport.git", from: "1.0.3"),
    .package(url: "https://github.com/grpc/grpc-swift-protobuf.git", from: "1.2.0"),
    .package(url: "https://github.com/grpc/grpc-swift.git", from: "2.1.2"),
    .package(url: "https://github.com/twostraws/Ignite.git", branch: "main"),
  ],
  targets: [
    .executableTarget(
      name: "svc",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "GRPCCore", package: "grpc-swift"),
        .product(name: "GRPCNIOTransportHTTP2", package: "grpc-swift-nio-transport"),
        .target(name: "api"),
      ]
    ),
    .target(
      name: "api",
      dependencies: [
        .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"),
      ],
      plugins: [.plugin(name: "GRPCProtobufGenerator", package: "grpc-swift-protobuf")],
    ),
  ],
)
