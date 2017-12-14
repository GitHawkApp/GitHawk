import Foundation

final class Assembly {
  fileprivate static let shared = Assembly()
}

var resolver: Assembly {
  return Assembly.shared
}
