import Foundation
final class Label: NSObject, NSCoding {
  struct Keys {
    static let default_ = "default"
    static let name = "name"
    static let id = "id"
    static let url = "url"
    static let color = "color"
  }
  let default_: Bool
  let name: String
  let id: NSNumber
  let url: String
  let color: String
  convenience init?(json: [String: Any]?) {
    guard let default_ = json?[Keys.default_] as? Bool else { return nil }
    guard let name = json?[Keys.name] as? String else { return nil }
    guard let id = json?[Keys.id] as? NSNumber else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    guard let color = json?[Keys.color] as? String else { return nil }
    self.init(
      default_: default_,
      name: name,
      id: id,
      url: url,
      color: color
    )
  }
  init(
    default_: Bool,
    name: String,
    id: NSNumber,
    url: String,
    color: String
    ) {
    self.default_ = default_
    self.name = name
    self.id = id
    self.url = url
    self.color = color
  }
  convenience init?(coder aDecoder: NSCoder) {
    let default_ = aDecoder.decodeBool(forKey: Keys.default_)
    guard let name = aDecoder.decodeObject(forKey: Keys.name) as? String else { return nil }
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    guard let color = aDecoder.decodeObject(forKey: Keys.color) as? String else { return nil }
    self.init(
      default_: default_,
      name: name,
      id: id,
      url: url,
      color: color
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(default_, forKey: Keys.default_)
    aCoder.encode(name, forKey: Keys.name)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(url, forKey: Keys.url)
    aCoder.encode(color, forKey: Keys.color)
  }
}