// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// Main package definition for the HTTP Swift Template project.
///
/// This package defines:
/// - External dependencies required for the project.
/// - Targets, including an executable target.
let package = Package(
  name: "web-swift-template",
  platforms: [.macOS("15.0")],

  // External dependencies required by this package.
  dependencies: [
    // Ignite is a library for building web applications in Swift.
    .package(url: "https://github.com/twostraws/Ignite.git", from: "0.6.0")
  ],

  // The targets that make up this package.
  targets: [
    // The main executable target.
    .executableTarget(
      name: "website",
      dependencies: [
        .product(name: "Ignite", package: "Ignite")
      ],
    ),
  ]
)
