// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// A reusable navigation bar component for the web template.
///
/// This component demonstrates how to create a navigation bar using the Ignite framework.
/// It includes links, a logo, and various styling options.
struct NavBar: HTML {
  /// The body of the navigation bar, defining its structure and content.
  var body: some HTML {
    NavigationBar {
      // Add a link to the "Readme" page.
      Link("Readme", target: "/readme")

      // Add a link to the GitHub repository.
      Link("GitHub", target: "https://github.com/anselmes/templates")
        .target(.newWindow) // Open the link in a new window.
        .linkStyle(.button) // Style the link as a button.
        .role(.dark)        // Apply a dark role style.
        .navigationBarVisibility(.always) // Ensure the link is always visible in the navigation bar.
    } logo: {
      // Add a logo image to the navigation bar.
      Image("/images/logo.svg", description: "Web Template")
        .frame(width: .custom("min(60vw, 300px)"), height: .percent(100%)) // Set the logo's dimensions.
    }
    .navigationItemAlignment(.trailing) // Align navigation items to the trailing edge.
    .navigationBarStyle(.dark)          // Apply a dark style to the navigation bar.
    .background(.firebrick)             // Set the background color to firebrick.
    .position(.fixedTop)                // Fix the navigation bar to the top of the page.
  }
}
