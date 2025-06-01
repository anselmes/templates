// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// A custom layout for rendering an article page.
///
/// This layout displays the article's title, optional image, tags, metadata (word count and reading time),
/// and the main content of the article.
struct CustomArticleLayout: ArticlePage {
  /// The body of the article layout, defining its structure and content.
  var body: some HTML {
    // Display the article's title with a large font size.
    Text(article.title).font(.title1)

    // If the article has an associated image, display it.
    if let image = article.image {
      Image(image, description: article.imageDescription)
        .resizable()            // Allow the image to be resized.
        .cornerRadius(20)       // Apply rounded corners with a radius of 20.
        .frame(maxHeight: 300)  // Limit the image's maximum height to 300 pixels.
    }

    // If the article has tags, display them along with metadata.
    if let tags = article.tags {
      Section {
        // Display the tags, separated by commas.
        Text("Tagged with: \(tags.joined(separator: ", "))")

        // Display the word count and estimated reading time.
        Text("\(article.estimatedWordCount) words; \(article.estimatedReadingMinutes) minutes to read.")
      }
    }

    // Display the main content of the article.
    Text(article.text)
  }
}
