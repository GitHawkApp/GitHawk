import Foundation
final class Permission: NSObject, NSCoding {
  enum Keys {
    static let push = "push"
    static let admin = "admin"
    static let pull = "pull"
  }
  let push: Bool
  let admin: Bool
  let pull: Bool
  convenience init?(json: [String: Any]?) {
    guard let push = json?[Keys.push] as? Bool else { return nil }
    guard let admin = json?[Keys.admin] as? Bool else { return nil }
    guard let pull = json?[Keys.pull] as? Bool else { return nil }
    self.init(
      push: push,
      admin: admin,
      pull: pull
    )
  }
  init(
    push: Bool,
    admin: Bool,
    pull: Bool
    ) {
    self.push = push
    self.admin = admin
    self.pull = pull
  }
  convenience init?(coder aDecoder: NSCoder) {
    let push = aDecoder.decodeBool(forKey: Keys.push)
    let admin = aDecoder.decodeBool(forKey: Keys.admin)
    let pull = aDecoder.decodeBool(forKey: Keys.pull)
    self.init(
      push: push,
      admin: admin,
      pull: pull
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(push, forKey: Keys.push)
    aCoder.encode(admin, forKey: Keys.admin)
    aCoder.encode(pull, forKey: Keys.pull)
  }
}
