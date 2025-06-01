// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// The main site configuration for the web template.
///
/// This struct defines the site's metadata, configuration options, and page structure.
/// It includes:
/// - Site metadata such as name, author, and URL.
/// - Configuration for feeds, layouts, robots, syntax highlighting, and Bootstrap.
/// - Definitions for the homepage, tag page, static pages, and article pages.
struct Web: Site {
  /// The name of the site.
  var name = "Web Template"

  /// The suffix appended to the title of each page.
  var titleSuffix = " (Swift)"

  /// The author of the site.
  var author = "Schubert Anselme <schubert@anselm.es>"

  /// The base URL of the site, fetched from the environment or defaulting to localhost.
  var url = URL(string: ProcessInfo.processInfo.environment["URL"] ?? "http://localhost:8080")!

  // MARK: - Configuration

  /// Enables or disables built-in icons for the site.
  var builtInIconsEnabled = true

  /// Configuration for the site's RSS/Atom feed.
  /// Includes mode, content count, and an image for the feed.
  var feedConfiguration = FeedConfiguration(
    mode: .full,
    contentCount: 20,
    image: .init(url: "/images/icon32.png", width: 32, height: 32)
  )

  /// The default layout used for the site's pages.
  var layout = DefaultLayout()

  /// Configuration for the `robots.txt` file.
  var robotsConfiguration = Robots()

  /// Configuration for syntax highlighting, specifying supported languages.
  var syntaxHighlighterConfiguration: SyntaxHighlighterConfiguration = .init(
    languages: [.swift, .python, .ruby]
  )

  /// Specifies whether to use remote or local Bootstrap URLs.
  var useDefaultBootstrapURLs: BootstrapOptions { .remoteBootstrap }

  // MARK: - Homepage

  /// The homepage of the site.
  var homePage = Home()

  /// The tag page, used to display articles grouped by tags.
  var tagPage = Tags()

  // MARK: - Pages

  /// A list of static pages on the site.
  var staticPages: [any StaticPage] = []

  /// A list of article pages on the site, using a custom article layout.
  var articlePages: [any ArticlePage] { CustomArticleLayout() }
}
