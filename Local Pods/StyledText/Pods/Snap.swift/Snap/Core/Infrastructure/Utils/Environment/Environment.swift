import Foundation

protocol Environment {
  func get(_ key: String) -> String?
}
