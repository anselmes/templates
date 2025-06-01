// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// The `Tags` page of the web template.
///
/// This page displays a list of articles associated with a specific tag.
/// It includes:
/// - The name of the tag as the page title.
/// - A list of links to articles associated with the tag.
struct Tags: TagPage {
  /// The body of the page, defining its structure and content.
  ///
  /// The body includes:
  /// - The tag name displayed as a title.
  /// - A list of articles associated with the tag, each displayed as a link.
  var body: some HTML {
    // Display the tag name as the page title.
    Text(tag.name).font(.title1)

    // Display a list of articles associated with the tag.
    List {
      // Iterate over the articles associated with the tag.
      ForEach(tag.articles) { article in
        // Create a link for each article.
        Link(article)
      }
    }
  }
}
