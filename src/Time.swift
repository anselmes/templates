public struct Time {}

// MARK: - Public API

public extension Time {
  static func sleep(ms: Int32) { k_msleep(ms) }
}
