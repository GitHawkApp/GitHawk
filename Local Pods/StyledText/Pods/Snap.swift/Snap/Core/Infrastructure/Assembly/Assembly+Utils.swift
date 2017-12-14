import Foundation

extension Assembly {
  var environment: Environment {
    return ApplicationEnvironment()
  }
}

// MARK: - Foundation

extension Assembly {
  var fileManager: FileManager {
    return .default
  }
}
