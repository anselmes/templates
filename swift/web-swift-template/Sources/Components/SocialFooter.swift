// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// A reusable "Social Footer" component for the web template.
///
/// This component displays a horizontal list of social media icons, each linking to an external site.
/// It demonstrates how to use built-in icons, external links, and custom attributes in a reusable way.
struct SocialFooter: HTML {
  /// An array of icons to display in the footer.
  /// Each icon represents a social media platform or external link.
  let icons = [Image(systemName: "github")]

  /// An array of URL strings corresponding to the icons.
  /// Each URL points to the external site for the respective icon.
  let urlStrings = ["https://github.com/sanselme"]

  /// The body of the social footer, defining its structure and content.
  var body: some HTML {
    VStack {
      // Create a horizontal stack for the social icons and links.
      HStack {
        // Iterate over the icons and URLs, pairing them together.
        ForEach(zip(icons, urlStrings)) { (icon, urlString) in
          // Create a link for each icon, pointing to the corresponding URL.
          Link(icon, target: urlString)
            .role(.secondary) // Apply a secondary role style to the link.
            .target(.blank)   // Open the link in a new browser tab.
            .relationship(.noOpener, .noReferrer) // Add security attributes to the link.
        }
      }
    }
    .margin(.top, .xLarge)  // Add a large top margin to the footer.
    .font(.title2)          // Set the font size for the footer content.
  }
}
