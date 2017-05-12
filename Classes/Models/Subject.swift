import Foundation
final class Subject: NSObject, NSCoding {
  struct Keys {
    static let title = "title"
    static let type = "type"
    static let latest_comment_url = "latest_comment_url"
    static let url = "url"
  }
  let title: String
  let type: String
  let latest_comment_url: String
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let title = json?[Keys.title] as? String else { return nil }
    guard let type = json?[Keys.type] as? String else { return nil }
    guard let latest_comment_url = json?[Keys.latest_comment_url] as? String else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      title: title,
      type: type,
      latest_comment_url: latest_comment_url,
      url: url
    )
  }
  init(
    title: String,
    type: String,
    latest_comment_url: String,
    url: String
    ) {
    self.title = title
    self.type = type
    self.latest_comment_url = latest_comment_url
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let title = aDecoder.decodeObject(forKey: Keys.title) as? String else { return nil }
    guard let type = aDecoder.decodeObject(forKey: Keys.type) as? String else { return nil }
    guard let latest_comment_url = aDecoder.decodeObject(forKey: Keys.latest_comment_url) as? String else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      title: title,
      type: type,
      latest_comment_url: latest_comment_url,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: Keys.title)
    aCoder.encode(type, forKey: Keys.type)
    aCoder.encode(latest_comment_url, forKey: Keys.latest_comment_url)
    aCoder.encode(url, forKey: Keys.url)
  }
}