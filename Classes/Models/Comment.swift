import Foundation
final class Comment: NSObject, NSCoding {
  struct Keys {
    static let user = "user"
    static let updated_at = "updated_at"
    static let href = "href"
    static let id = "id"
    static let html_url = "html_url"
    static let body = "body"
    static let created_at = "created_at"
    static let url = "url"
  }
  let user: User?
  let updated_at: String?
  let href: String?
  let id: NSNumber?
  let html_url: String?
  let body: String?
  let created_at: String?
  let url: String?
  convenience init?(json: [String: Any]?) {
    let userJSON = json?[Keys.user] as? [String: Any]
    let user = User(json: userJSON)
    let updated_at = json?[Keys.updated_at] as? String
    let href = json?[Keys.href] as? String
    let id = json?[Keys.id] as? NSNumber
    let html_url = json?[Keys.html_url] as? String
    let body = json?[Keys.body] as? String
    let created_at = json?[Keys.created_at] as? String
    let url = json?[Keys.url] as? String
    self.init(
      user: user,
      updated_at: updated_at,
      href: href,
      id: id,
      html_url: html_url,
      body: body,
      created_at: created_at,
      url: url
    )
  }
  init(
    user: User?,
    updated_at: String?,
    href: String?,
    id: NSNumber?,
    html_url: String?,
    body: String?,
    created_at: String?,
    url: String?
    ) {
    self.user = user
    self.updated_at = updated_at
    self.href = href
    self.id = id
    self.html_url = html_url
    self.body = body
    self.created_at = created_at
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    let user = aDecoder.decodeObject(forKey: Keys.user) as? User
    let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String
    let href = aDecoder.decodeObject(forKey: Keys.href) as? String
    let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber
    let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String
    let body = aDecoder.decodeObject(forKey: Keys.body) as? String
    let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String
    let url = aDecoder.decodeObject(forKey: Keys.url) as? String
    self.init(
      user: user,
      updated_at: updated_at,
      href: href,
      id: id,
      html_url: html_url,
      body: body,
      created_at: created_at,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(user, forKey: Keys.user)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(href, forKey: Keys.href)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(body, forKey: Keys.body)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(url, forKey: Keys.url)
  }
}