import Foundation

final class App: NSObject, NSCoding {
  enum Keys {
    static let name = "name"
    static let client_id = "client_id"
    static let url = "url"
  }
  let name: String
  let client_id: String
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let name = json?[Keys.name] as? String else { return nil }
    guard let client_id = json?[Keys.client_id] as? String else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      name: name,
      client_id: client_id,
      url: url
    )
  }
  init(
    name: String,
    client_id: String,
    url: String
    ) {
    self.name = name
    self.client_id = client_id
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let name = aDecoder.decodeObject(forKey: Keys.name) as? String else { return nil }
    guard let client_id = aDecoder.decodeObject(forKey: Keys.client_id) as? String else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      name: name,
      client_id: client_id,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: Keys.name)
    aCoder.encode(client_id, forKey: Keys.client_id)
    aCoder.encode(url, forKey: Keys.url)
  }
}
