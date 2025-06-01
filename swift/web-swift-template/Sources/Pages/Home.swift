// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

import Foundation
import Ignite

/// The `Home` page of the web template.
///
/// This page serves as the landing page and includes:
/// - A welcome message.
/// - A form with a text field and a button to display a greeting.
/// - A hidden text element that is revealed upon form submission.
struct Home: StaticPage {
  /// The title of the page, displayed in the browser tab or metadata.
  var title = "Home"

  /// The body of the page, defining its structure and content.
  ///
  /// The body includes:
  /// - A welcome message styled as a title.
  /// - A form with a text field for user input and a button to trigger an action.
  /// - A hidden greeting message that is revealed when the button is clicked.
  var body: some HTML {
    // Display a welcome message at the top of the page.
    Text("Welcome to Web Template!").font(.title1)

    // Create a form with a text field and a button.
    Form {
      ControlGroup {
        // Add a text field for the user to input their name.
        TextField("Name", prompt: "Enter your name")
          .type(.text) // Set the input type to text.
          .width(1)    // Set the width of the text field.

        // Add a button to submit the form and reveal the hidden text.
        Button("Greet") {
          ShowElement("HiddenText") // Action to reveal the hidden text element.
        }
        .type(.submit)  // Set the button type to submit.
        .role(.primary) // Style the button as a primary action.
        .width(1)       // Set the width of the button.
      }
    }
    .columns(2)               // Arrange the form elements in two columns.
    .margin(.bottom, .xLarge) // Add extra bottom margin to the form.

    // Add a horizontal divider below the form.
    Divider()

    // Display a hidden greeting message that is revealed upon form submission.
    // TODO: Update this text to use the name entered in the text field.
    Text("Hello, World!")
      .font(.title3)    // Style the text as a title.
      .id("HiddenText") // Assign an ID to the text for reference.
      .hidden()         // Initially hide the text.
  }
}
