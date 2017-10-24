import Foundation
final class Link: NSObject, NSCoding {
  struct Keys {
    static let self_ = "self"
    static let git = "git"
    static let html = "html"
  }
  let self_: String
  let git: String
  let html: String
  convenience init?(json: [String: Any]?) {
    guard let self_ = json?[Keys.self_] as? String else { return nil }
    guard let git = json?[Keys.git] as? String else { return nil }
    guard let html = json?[Keys.html] as? String else { return nil }
    self.init(
      self_: self_,
      git: git,
      html: html
    )
  }
  init(
    self_: String,
    git: String,
    html: String
    ) {
    self.self_ = self_
    self.git = git
    self.html = html
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let self_ = aDecoder.decodeObject(forKey: Keys.self_) as? String else { return nil }
    guard let git = aDecoder.decodeObject(forKey: Keys.git) as? String else { return nil }
    guard let html = aDecoder.decodeObject(forKey: Keys.html) as? String else { return nil }
    self.init(
      self_: self_,
      git: git,
      html: html
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self_, forKey: Keys.self_)
    aCoder.encode(git, forKey: Keys.git)
    aCoder.encode(html, forKey: Keys.html)
  }
}
