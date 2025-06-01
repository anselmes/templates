// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Ignite

/// A component that displays version information for the Ignite framework and the last publishing date.
///
/// This component is useful for showing metadata about the site, such as the framework version
/// and the date it was last updated.
struct VersionInfo: HTML {
  /// The date format used to display the publishing date.
  /// The format includes the month, day, and year (two digits).
  private let dateFormat = Date.FormatStyle()
    .month(.defaultDigits)
    .day(.defaultDigits)
    .year(.twoDigits)

  /// The body of the component, defining its structure and content.
  /// It displays the Ignite version and the formatted publishing date.
  var body: some HTML {
    Text("\(Ignite.version) · Updated \(Date.now.formatted(dateFormat))")
      .horizontalAlignment(.center) // Center-align the text horizontally.
      .foregroundStyle(.gray)       // Set the text color to gray.
  }
}
