// Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
// SPDX-Licence-Identifier: GPL-3.0

public struct Time {}

// MARK: - Public API

public extension Time {
  static func sleep(ms: Int32) { k_msleep(ms) }
}
