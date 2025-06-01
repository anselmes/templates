// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// A custom `robots.txt` configuration for the web template.
///
/// This configuration defines rules to block specific paths from being indexed
/// by certain search engines (e.g., Google and Bing) and blocks all access for ChatGPT.
struct Robots: RobotsConfiguration {
  /// An array of disallow rules specifying which robots are restricted from accessing certain paths.
  var disallowRules: [DisallowRule]

  /// Initializes the `Robots` configuration with predefined disallow rules.
  init() {
    // Define the paths to be blocked for specific robots.
    let paths = [
      "/admin",    // Block access to the admin section.
      "/settings", // Block access to the settings section.
    ]

    // Define disallow rules for specific robots.
    disallowRules = [
      DisallowRule(robot: .google, paths: paths), // Block Google from accessing the specified paths.
      DisallowRule(robot: .bing, paths: paths),   // Block Bing from accessing the specified paths.
      DisallowRule(robot: .chatGPT),              // Block ChatGPT from accessing all paths.
    ]
  }
}
