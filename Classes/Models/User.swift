import Foundation
final class User: NSObject, NSCoding {
  enum Keys {
    static let public_repos = "public_repos"
    static let organizations_url = "organizations_url"
    static let repos_url = "repos_url"
    static let starred_url = "starred_url"
    static let type = "type"
    static let gists_url = "gists_url"
    static let bio = "bio"
    static let followers_url = "followers_url"
    static let id = "id"
    static let blog = "blog"
    static let followers = "followers"
    static let following = "following"
    static let company = "company"
    static let url = "url"
    static let name = "name"
    static let updated_at = "updated_at"
    static let html_url = "html_url"
    static let site_admin = "site_admin"
    static let public_gists = "public_gists"
    static let gravatar_id = "gravatar_id"
    static let email = "email"
    static let avatar_url = "avatar_url"
    static let login = "login"
    static let location = "location"
    static let created_at = "created_at"
    static let subscriptions_url = "subscriptions_url"
    static let following_url = "following_url"
    static let received_events_url = "received_events_url"
    static let events_url = "events_url"
    static let hireable = "hireable"
  }
  let public_repos: NSNumber?
  let organizations_url: String
  let repos_url: String
  let starred_url: String
  let type: String
  let gists_url: String
  let bio: String?
  let followers_url: String
  let id: NSNumber
  let blog: String?
  let followers: NSNumber?
  let following: NSNumber?
  let company: String?
  let url: String
  let name: String?
  let updated_at: String?
  let html_url: String
  let site_admin: Bool
  let public_gists: NSNumber?
  let gravatar_id: String
  let email: String?
  let avatar_url: String
  let login: String
  let location: String?
  let created_at: String?
  let subscriptions_url: String
  let following_url: String
  let received_events_url: String
  let events_url: String
  let hireable: Bool?
  convenience init?(json: [String: Any]?) {
    let public_repos = json?[Keys.public_repos] as? NSNumber
    guard let organizations_url = json?[Keys.organizations_url] as? String else { return nil }
    guard let repos_url = json?[Keys.repos_url] as? String else { return nil }
    guard let starred_url = json?[Keys.starred_url] as? String else { return nil }
    guard let type = json?[Keys.type] as? String else { return nil }
    guard let gists_url = json?[Keys.gists_url] as? String else { return nil }
    let bio = json?[Keys.bio] as? String
    guard let followers_url = json?[Keys.followers_url] as? String else { return nil }
    guard let id = json?[Keys.id] as? NSNumber else { return nil }
    let blog = json?[Keys.blog] as? String
    let followers = json?[Keys.followers] as? NSNumber
    let following = json?[Keys.following] as? NSNumber
    let company = json?[Keys.company] as? String
    guard let url = json?[Keys.url] as? String else { return nil }
    let name = json?[Keys.name] as? String
    let updated_at = json?[Keys.updated_at] as? String
    guard let html_url = json?[Keys.html_url] as? String else { return nil }
    guard let site_admin = json?[Keys.site_admin] as? Bool else { return nil }
    let public_gists = json?[Keys.public_gists] as? NSNumber
    guard let gravatar_id = json?[Keys.gravatar_id] as? String else { return nil }
    let email = json?[Keys.email] as? String
    guard let avatar_url = json?[Keys.avatar_url] as? String else { return nil }
    guard let login = json?[Keys.login] as? String else { return nil }
    let location = json?[Keys.location] as? String
    let created_at = json?[Keys.created_at] as? String
    guard let subscriptions_url = json?[Keys.subscriptions_url] as? String else { return nil }
    guard let following_url = json?[Keys.following_url] as? String else { return nil }
    guard let received_events_url = json?[Keys.received_events_url] as? String else { return nil }
    guard let events_url = json?[Keys.events_url] as? String else { return nil }
    let hireable = json?[Keys.hireable] as? Bool
    self.init(
      public_repos: public_repos,
      organizations_url: organizations_url,
      repos_url: repos_url,
      starred_url: starred_url,
      type: type,
      gists_url: gists_url,
      bio: bio,
      followers_url: followers_url,
      id: id,
      blog: blog,
      followers: followers,
      following: following,
      company: company,
      url: url,
      name: name,
      updated_at: updated_at,
      html_url: html_url,
      site_admin: site_admin,
      public_gists: public_gists,
      gravatar_id: gravatar_id,
      email: email,
      avatar_url: avatar_url,
      login: login,
      location: location,
      created_at: created_at,
      subscriptions_url: subscriptions_url,
      following_url: following_url,
      received_events_url: received_events_url,
      events_url: events_url,
      hireable: hireable
    )
  }
  init(
    public_repos: NSNumber?,
    organizations_url: String,
    repos_url: String,
    starred_url: String,
    type: String,
    gists_url: String,
    bio: String?,
    followers_url: String,
    id: NSNumber,
    blog: String?,
    followers: NSNumber?,
    following: NSNumber?,
    company: String?,
    url: String,
    name: String?,
    updated_at: String?,
    html_url: String,
    site_admin: Bool,
    public_gists: NSNumber?,
    gravatar_id: String,
    email: String?,
    avatar_url: String,
    login: String,
    location: String?,
    created_at: String?,
    subscriptions_url: String,
    following_url: String,
    received_events_url: String,
    events_url: String,
    hireable: Bool?
    ) {
    self.public_repos = public_repos
    self.organizations_url = organizations_url
    self.repos_url = repos_url
    self.starred_url = starred_url
    self.type = type
    self.gists_url = gists_url
    self.bio = bio
    self.followers_url = followers_url
    self.id = id
    self.blog = blog
    self.followers = followers
    self.following = following
    self.company = company
    self.url = url
    self.name = name
    self.updated_at = updated_at
    self.html_url = html_url
    self.site_admin = site_admin
    self.public_gists = public_gists
    self.gravatar_id = gravatar_id
    self.email = email
    self.avatar_url = avatar_url
    self.login = login
    self.location = location
    self.created_at = created_at
    self.subscriptions_url = subscriptions_url
    self.following_url = following_url
    self.received_events_url = received_events_url
    self.events_url = events_url
    self.hireable = hireable
  }
  convenience init?(coder aDecoder: NSCoder) {
    let public_repos = aDecoder.decodeObject(forKey: Keys.public_repos) as? NSNumber
    guard let organizations_url = aDecoder.decodeObject(forKey: Keys.organizations_url) as? String else { return nil }
    guard let repos_url = aDecoder.decodeObject(forKey: Keys.repos_url) as? String else { return nil }
    guard let starred_url = aDecoder.decodeObject(forKey: Keys.starred_url) as? String else { return nil }
    guard let type = aDecoder.decodeObject(forKey: Keys.type) as? String else { return nil }
    guard let gists_url = aDecoder.decodeObject(forKey: Keys.gists_url) as? String else { return nil }
    let bio = aDecoder.decodeObject(forKey: Keys.bio) as? String
    guard let followers_url = aDecoder.decodeObject(forKey: Keys.followers_url) as? String else { return nil }
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber else { return nil }
    let blog = aDecoder.decodeObject(forKey: Keys.blog) as? String
    let followers = aDecoder.decodeObject(forKey: Keys.followers) as? NSNumber
    let following = aDecoder.decodeObject(forKey: Keys.following) as? NSNumber
    let company = aDecoder.decodeObject(forKey: Keys.company) as? String
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    let name = aDecoder.decodeObject(forKey: Keys.name) as? String
    let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String
    guard let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String else { return nil }
    let site_admin = aDecoder.decodeBool(forKey: Keys.site_admin)
    let public_gists = aDecoder.decodeObject(forKey: Keys.public_gists) as? NSNumber
    guard let gravatar_id = aDecoder.decodeObject(forKey: Keys.gravatar_id) as? String else { return nil }
    let email = aDecoder.decodeObject(forKey: Keys.email) as? String
    guard let avatar_url = aDecoder.decodeObject(forKey: Keys.avatar_url) as? String else { return nil }
    guard let login = aDecoder.decodeObject(forKey: Keys.login) as? String else { return nil }
    let location = aDecoder.decodeObject(forKey: Keys.location) as? String
    let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String
    guard let subscriptions_url = aDecoder.decodeObject(forKey: Keys.subscriptions_url) as? String else { return nil }
    guard let following_url = aDecoder.decodeObject(forKey: Keys.following_url) as? String else { return nil }
    guard let received_events_url = aDecoder.decodeObject(forKey: Keys.received_events_url) as? String else { return nil }
    guard let events_url = aDecoder.decodeObject(forKey: Keys.events_url) as? String else { return nil }
    let hireable = aDecoder.decodeObject(forKey: Keys.hireable) as? Bool
    self.init(
      public_repos: public_repos,
      organizations_url: organizations_url,
      repos_url: repos_url,
      starred_url: starred_url,
      type: type,
      gists_url: gists_url,
      bio: bio,
      followers_url: followers_url,
      id: id,
      blog: blog,
      followers: followers,
      following: following,
      company: company,
      url: url,
      name: name,
      updated_at: updated_at,
      html_url: html_url,
      site_admin: site_admin,
      public_gists: public_gists,
      gravatar_id: gravatar_id,
      email: email,
      avatar_url: avatar_url,
      login: login,
      location: location,
      created_at: created_at,
      subscriptions_url: subscriptions_url,
      following_url: following_url,
      received_events_url: received_events_url,
      events_url: events_url,
      hireable: hireable
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(public_repos, forKey: Keys.public_repos)
    aCoder.encode(organizations_url, forKey: Keys.organizations_url)
    aCoder.encode(repos_url, forKey: Keys.repos_url)
    aCoder.encode(starred_url, forKey: Keys.starred_url)
    aCoder.encode(type, forKey: Keys.type)
    aCoder.encode(gists_url, forKey: Keys.gists_url)
    aCoder.encode(bio, forKey: Keys.bio)
    aCoder.encode(followers_url, forKey: Keys.followers_url)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(blog, forKey: Keys.blog)
    aCoder.encode(followers, forKey: Keys.followers)
    aCoder.encode(following, forKey: Keys.following)
    aCoder.encode(company, forKey: Keys.company)
    aCoder.encode(url, forKey: Keys.url)
    aCoder.encode(name, forKey: Keys.name)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(site_admin, forKey: Keys.site_admin)
    aCoder.encode(public_gists, forKey: Keys.public_gists)
    aCoder.encode(gravatar_id, forKey: Keys.gravatar_id)
    aCoder.encode(email, forKey: Keys.email)
    aCoder.encode(avatar_url, forKey: Keys.avatar_url)
    aCoder.encode(login, forKey: Keys.login)
    aCoder.encode(location, forKey: Keys.location)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(subscriptions_url, forKey: Keys.subscriptions_url)
    aCoder.encode(following_url, forKey: Keys.following_url)
    aCoder.encode(received_events_url, forKey: Keys.received_events_url)
    aCoder.encode(events_url, forKey: Keys.events_url)
    aCoder.encode(hireable, forKey: Keys.hireable)
  }
}
