// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// A default layout for the web template.
///
/// This layout defines the overall structure of the web page, including:
/// - A navigation bar at the top.
/// - A main content area for dynamic page content.
/// - A footer section with social links, framework information, and version details.
struct DefaultLayout: Layout {
  /// The body of the layout, defining its structure and content.
  ///
  /// The layout includes:
  /// - A `NavBar` component at the top with padding below it.
  /// - The `content` placeholder for the main page content.
  /// - A footer section with social links, the Ignite footer, and version information (in debug mode).
  var body: some Document {
    Body {
      // Add the navigation bar at the top of the page with padding below it.
      NavBar().padding(.bottom, 100)

      // Insert the main content of the page.
      content

      // Add a footer section containing social links, the Ignite footer, and version information.
      Section {
        SocialFooter() // Display social media links.
        IgniteFooter() // Display the Ignite framework footer.

        #if DEBUG
          // Display version information with a bottom margin in debug mode.
          VersionInfo().margin(.bottom, 80)
        #endif
      }
    }
  }
}
