import Foundation
final class Commit: NSObject, NSCoding {
  struct Keys {
    static let href = "href"
  }
  let href: String
  convenience init?(json: [String: Any]?) {
    guard let href = json?[Keys.href] as? String else { return nil }
    self.init(
      href: href
    )
  }
  init(
    href: String
    ) {
    self.href = href
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let href = aDecoder.decodeObject(forKey: Keys.href) as? String else { return nil }
    self.init(
      href: href
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(href, forKey: Keys.href)
  }
}