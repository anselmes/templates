// swift-tools-version: 6.1
// This declares the minimum version of Swift required to build this package

import PackageDescription

/// Main package definition for the HTTP Swift Template project.
///
/// This package defines:
/// - An executable target that implements and runs the HTTP server.
/// - External dependencies required for the project, such as Vapor.
let package = Package(
    name: "http-swift-template",
    platforms: [.macOS(.v12)],

    // External dependencies required by this package.
    dependencies: [
        // Vapor is a web framework for Swift, used to build HTTP servers and APIs.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0"),
    ],

    // The targets that make up this package.
    targets: [
        // Main executable target that runs the HTTP server.
        .executableTarget(
            name: "server",
            dependencies: [
                .product(name: "Vapor", package: "vapor") // The Vapor product is used as a dependency for the server target.
            ]
        ),
    ]
)
