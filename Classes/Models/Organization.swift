import Foundation
final class Organization: NSObject, NSCoding {
  struct Keys {
    static let organizations_url = "organizations_url"
    static let repos_url = "repos_url"
    static let html_url = "html_url"
    static let site_admin = "site_admin"
    static let gravatar_id = "gravatar_id"
    static let starred_url = "starred_url"
    static let avatar_url = "avatar_url"
    static let type = "type"
    static let gists_url = "gists_url"
    static let login = "login"
    static let followers_url = "followers_url"
    static let id = "id"
    static let subscriptions_url = "subscriptions_url"
    static let following_url = "following_url"
    static let received_events_url = "received_events_url"
    static let events_url = "events_url"
    static let url = "url"
  }
  let organizations_url: String
  let repos_url: String
  let html_url: String
  let site_admin: Bool
  let gravatar_id: String
  let starred_url: String
  let avatar_url: String
  let type: String
  let gists_url: String
  let login: String
  let followers_url: String
  let id: NSNumber
  let subscriptions_url: String
  let following_url: String
  let received_events_url: String
  let events_url: String
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let organizations_url = json?[Keys.organizations_url] as? String else { return nil }
    guard let repos_url = json?[Keys.repos_url] as? String else { return nil }
    guard let html_url = json?[Keys.html_url] as? String else { return nil }
    guard let site_admin = json?[Keys.site_admin] as? Bool else { return nil }
    guard let gravatar_id = json?[Keys.gravatar_id] as? String else { return nil }
    guard let starred_url = json?[Keys.starred_url] as? String else { return nil }
    guard let avatar_url = json?[Keys.avatar_url] as? String else { return nil }
    guard let type = json?[Keys.type] as? String else { return nil }
    guard let gists_url = json?[Keys.gists_url] as? String else { return nil }
    guard let login = json?[Keys.login] as? String else { return nil }
    guard let followers_url = json?[Keys.followers_url] as? String else { return nil }
    guard let id = json?[Keys.id] as? NSNumber else { return nil }
    guard let subscriptions_url = json?[Keys.subscriptions_url] as? String else { return nil }
    guard let following_url = json?[Keys.following_url] as? String else { return nil }
    guard let received_events_url = json?[Keys.received_events_url] as? String else { return nil }
    guard let events_url = json?[Keys.events_url] as? String else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      organizations_url: organizations_url,
      repos_url: repos_url,
      html_url: html_url,
      site_admin: site_admin,
      gravatar_id: gravatar_id,
      starred_url: starred_url,
      avatar_url: avatar_url,
      type: type,
      gists_url: gists_url,
      login: login,
      followers_url: followers_url,
      id: id,
      subscriptions_url: subscriptions_url,
      following_url: following_url,
      received_events_url: received_events_url,
      events_url: events_url,
      url: url
    )
  }
  init(
    organizations_url: String,
    repos_url: String,
    html_url: String,
    site_admin: Bool,
    gravatar_id: String,
    starred_url: String,
    avatar_url: String,
    type: String,
    gists_url: String,
    login: String,
    followers_url: String,
    id: NSNumber,
    subscriptions_url: String,
    following_url: String,
    received_events_url: String,
    events_url: String,
    url: String
    ) {
    self.organizations_url = organizations_url
    self.repos_url = repos_url
    self.html_url = html_url
    self.site_admin = site_admin
    self.gravatar_id = gravatar_id
    self.starred_url = starred_url
    self.avatar_url = avatar_url
    self.type = type
    self.gists_url = gists_url
    self.login = login
    self.followers_url = followers_url
    self.id = id
    self.subscriptions_url = subscriptions_url
    self.following_url = following_url
    self.received_events_url = received_events_url
    self.events_url = events_url
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let organizations_url = aDecoder.decodeObject(forKey: Keys.organizations_url) as? String else { return nil }
    guard let repos_url = aDecoder.decodeObject(forKey: Keys.repos_url) as? String else { return nil }
    guard let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String else { return nil }
    let site_admin = aDecoder.decodeBool(forKey: Keys.site_admin)
    guard let gravatar_id = aDecoder.decodeObject(forKey: Keys.gravatar_id) as? String else { return nil }
    guard let starred_url = aDecoder.decodeObject(forKey: Keys.starred_url) as? String else { return nil }
    guard let avatar_url = aDecoder.decodeObject(forKey: Keys.avatar_url) as? String else { return nil }
    guard let type = aDecoder.decodeObject(forKey: Keys.type) as? String else { return nil }
    guard let gists_url = aDecoder.decodeObject(forKey: Keys.gists_url) as? String else { return nil }
    guard let login = aDecoder.decodeObject(forKey: Keys.login) as? String else { return nil }
    guard let followers_url = aDecoder.decodeObject(forKey: Keys.followers_url) as? String else { return nil }
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber else { return nil }
    guard let subscriptions_url = aDecoder.decodeObject(forKey: Keys.subscriptions_url) as? String else { return nil }
    guard let following_url = aDecoder.decodeObject(forKey: Keys.following_url) as? String else { return nil }
    guard let received_events_url = aDecoder.decodeObject(forKey: Keys.received_events_url) as? String else { return nil }
    guard let events_url = aDecoder.decodeObject(forKey: Keys.events_url) as? String else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      organizations_url: organizations_url,
      repos_url: repos_url,
      html_url: html_url,
      site_admin: site_admin,
      gravatar_id: gravatar_id,
      starred_url: starred_url,
      avatar_url: avatar_url,
      type: type,
      gists_url: gists_url,
      login: login,
      followers_url: followers_url,
      id: id,
      subscriptions_url: subscriptions_url,
      following_url: following_url,
      received_events_url: received_events_url,
      events_url: events_url,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(organizations_url, forKey: Keys.organizations_url)
    aCoder.encode(repos_url, forKey: Keys.repos_url)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(site_admin, forKey: Keys.site_admin)
    aCoder.encode(gravatar_id, forKey: Keys.gravatar_id)
    aCoder.encode(starred_url, forKey: Keys.starred_url)
    aCoder.encode(avatar_url, forKey: Keys.avatar_url)
    aCoder.encode(type, forKey: Keys.type)
    aCoder.encode(gists_url, forKey: Keys.gists_url)
    aCoder.encode(login, forKey: Keys.login)
    aCoder.encode(followers_url, forKey: Keys.followers_url)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(subscriptions_url, forKey: Keys.subscriptions_url)
    aCoder.encode(following_url, forKey: Keys.following_url)
    aCoder.encode(received_events_url, forKey: Keys.received_events_url)
    aCoder.encode(events_url, forKey: Keys.events_url)
    aCoder.encode(url, forKey: Keys.url)
  }
}