// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

@main struct App {
  static func main() {
    print("Hello from Swift!")

    // Enter an infinite loop to keep the application running.
    while true {
      Time.sleep(ms: 10000) // Sleep for 10,000 milliseconds (10 seconds) between iterations.
      print("Still running...")
    }
  }
}
