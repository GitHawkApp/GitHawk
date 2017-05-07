//
//  User.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class User: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let publicRepos = "public_repos"
    static let organizationsUrl = "organizations_url"
    static let reposUrl = "repos_url"
    static let starredUrl = "starred_url"
    static let type = "type"
    static let gistsUrl = "gists_url"
    static let bio = "bio"
    static let followersUrl = "followers_url"
    static let id = "id"
    static let blog = "blog"
    static let followers = "followers"
    static let following = "following"
    static let company = "company"
    static let url = "url"
    static let name = "name"
    static let updatedAt = "updated_at"
    static let htmlUrl = "html_url"
    static let siteAdmin = "site_admin"
    static let publicGists = "public_gists"
    static let gravatarId = "gravatar_id"
    static let email = "email"
    static let avatarUrl = "avatar_url"
    static let login = "login"
    static let location = "location"
    static let createdAt = "created_at"
    static let subscriptionsUrl = "subscriptions_url"
    static let followingUrl = "following_url"
    static let receivedEventsUrl = "received_events_url"
    static let eventsUrl = "events_url"
    static let hireable = "hireable"
  }

  // MARK: Properties
  public var publicRepos: Int?
  public var organizationsUrl: String?
  public var reposUrl: String?
  public var starredUrl: String?
  public var type: String?
  public var gistsUrl: String?
  public var bio: String?
  public var followersUrl: String?
  public var id: Int?
  public var blog: String?
  public var followers: Int?
  public var following: Int?
  public var company: String?
  public var url: String?
  public var name: String?
  public var updatedAt: String?
  public var htmlUrl: String?
  public var siteAdmin: Bool? = false
  public var publicGists: Int?
  public var gravatarId: String?
  public var email: String?
  public var avatarUrl: String?
  public var login: String?
  public var location: String?
  public var createdAt: String?
  public var subscriptionsUrl: String?
  public var followingUrl: String?
  public var receivedEventsUrl: String?
  public var eventsUrl: String?
  public var hireable: Bool? = false

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    publicRepos = json[SerializationKeys.publicRepos].int
    organizationsUrl = json[SerializationKeys.organizationsUrl].string
    reposUrl = json[SerializationKeys.reposUrl].string
    starredUrl = json[SerializationKeys.starredUrl].string
    type = json[SerializationKeys.type].string
    gistsUrl = json[SerializationKeys.gistsUrl].string
    bio = json[SerializationKeys.bio].string
    followersUrl = json[SerializationKeys.followersUrl].string
    id = json[SerializationKeys.id].int
    blog = json[SerializationKeys.blog].string
    followers = json[SerializationKeys.followers].int
    following = json[SerializationKeys.following].int
    company = json[SerializationKeys.company].string
    url = json[SerializationKeys.url].string
    name = json[SerializationKeys.name].string
    updatedAt = json[SerializationKeys.updatedAt].string
    htmlUrl = json[SerializationKeys.htmlUrl].string
    siteAdmin = json[SerializationKeys.siteAdmin].boolValue
    publicGists = json[SerializationKeys.publicGists].int
    gravatarId = json[SerializationKeys.gravatarId].string
    email = json[SerializationKeys.email].string
    avatarUrl = json[SerializationKeys.avatarUrl].string
    login = json[SerializationKeys.login].string
    location = json[SerializationKeys.location].string
    createdAt = json[SerializationKeys.createdAt].string
    subscriptionsUrl = json[SerializationKeys.subscriptionsUrl].string
    followingUrl = json[SerializationKeys.followingUrl].string
    receivedEventsUrl = json[SerializationKeys.receivedEventsUrl].string
    eventsUrl = json[SerializationKeys.eventsUrl].string
    hireable = json[SerializationKeys.hireable].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = publicRepos { dictionary[SerializationKeys.publicRepos] = value }
    if let value = organizationsUrl { dictionary[SerializationKeys.organizationsUrl] = value }
    if let value = reposUrl { dictionary[SerializationKeys.reposUrl] = value }
    if let value = starredUrl { dictionary[SerializationKeys.starredUrl] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = gistsUrl { dictionary[SerializationKeys.gistsUrl] = value }
    if let value = bio { dictionary[SerializationKeys.bio] = value }
    if let value = followersUrl { dictionary[SerializationKeys.followersUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = blog { dictionary[SerializationKeys.blog] = value }
    if let value = followers { dictionary[SerializationKeys.followers] = value }
    if let value = following { dictionary[SerializationKeys.following] = value }
    if let value = company { dictionary[SerializationKeys.company] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    dictionary[SerializationKeys.siteAdmin] = siteAdmin
    if let value = publicGists { dictionary[SerializationKeys.publicGists] = value }
    if let value = gravatarId { dictionary[SerializationKeys.gravatarId] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
    if let value = login { dictionary[SerializationKeys.login] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = subscriptionsUrl { dictionary[SerializationKeys.subscriptionsUrl] = value }
    if let value = followingUrl { dictionary[SerializationKeys.followingUrl] = value }
    if let value = receivedEventsUrl { dictionary[SerializationKeys.receivedEventsUrl] = value }
    if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
    dictionary[SerializationKeys.hireable] = hireable
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.publicRepos = aDecoder.decodeObject(forKey: SerializationKeys.publicRepos) as? Int
    self.organizationsUrl = aDecoder.decodeObject(forKey: SerializationKeys.organizationsUrl) as? String
    self.reposUrl = aDecoder.decodeObject(forKey: SerializationKeys.reposUrl) as? String
    self.starredUrl = aDecoder.decodeObject(forKey: SerializationKeys.starredUrl) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.gistsUrl = aDecoder.decodeObject(forKey: SerializationKeys.gistsUrl) as? String
    self.bio = aDecoder.decodeObject(forKey: SerializationKeys.bio) as? String
    self.followersUrl = aDecoder.decodeObject(forKey: SerializationKeys.followersUrl) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.blog = aDecoder.decodeObject(forKey: SerializationKeys.blog) as? String
    self.followers = aDecoder.decodeObject(forKey: SerializationKeys.followers) as? Int
    self.following = aDecoder.decodeObject(forKey: SerializationKeys.following) as? Int
    self.company = aDecoder.decodeObject(forKey: SerializationKeys.company) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.siteAdmin = aDecoder.decodeBool(forKey: SerializationKeys.siteAdmin)
    self.publicGists = aDecoder.decodeObject(forKey: SerializationKeys.publicGists) as? Int
    self.gravatarId = aDecoder.decodeObject(forKey: SerializationKeys.gravatarId) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.avatarUrl = aDecoder.decodeObject(forKey: SerializationKeys.avatarUrl) as? String
    self.login = aDecoder.decodeObject(forKey: SerializationKeys.login) as? String
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.subscriptionsUrl = aDecoder.decodeObject(forKey: SerializationKeys.subscriptionsUrl) as? String
    self.followingUrl = aDecoder.decodeObject(forKey: SerializationKeys.followingUrl) as? String
    self.receivedEventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.receivedEventsUrl) as? String
    self.eventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.eventsUrl) as? String
    self.hireable = aDecoder.decodeBool(forKey: SerializationKeys.hireable)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(publicRepos, forKey: SerializationKeys.publicRepos)
    aCoder.encode(organizationsUrl, forKey: SerializationKeys.organizationsUrl)
    aCoder.encode(reposUrl, forKey: SerializationKeys.reposUrl)
    aCoder.encode(starredUrl, forKey: SerializationKeys.starredUrl)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(gistsUrl, forKey: SerializationKeys.gistsUrl)
    aCoder.encode(bio, forKey: SerializationKeys.bio)
    aCoder.encode(followersUrl, forKey: SerializationKeys.followersUrl)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(blog, forKey: SerializationKeys.blog)
    aCoder.encode(followers, forKey: SerializationKeys.followers)
    aCoder.encode(following, forKey: SerializationKeys.following)
    aCoder.encode(company, forKey: SerializationKeys.company)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(siteAdmin, forKey: SerializationKeys.siteAdmin)
    aCoder.encode(publicGists, forKey: SerializationKeys.publicGists)
    aCoder.encode(gravatarId, forKey: SerializationKeys.gravatarId)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(avatarUrl, forKey: SerializationKeys.avatarUrl)
    aCoder.encode(login, forKey: SerializationKeys.login)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(subscriptionsUrl, forKey: SerializationKeys.subscriptionsUrl)
    aCoder.encode(followingUrl, forKey: SerializationKeys.followingUrl)
    aCoder.encode(receivedEventsUrl, forKey: SerializationKeys.receivedEventsUrl)
    aCoder.encode(eventsUrl, forKey: SerializationKeys.eventsUrl)
    aCoder.encode(hireable, forKey: SerializationKeys.hireable)
  }

}
