import Foundation

struct ApplicationEnvironment: Environment {
  
  func get(_ key: String) -> String? {
    return ProcessInfo.processInfo.environment[key]
  }
}
