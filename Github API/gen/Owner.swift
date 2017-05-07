//
//  Owner.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Owner: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let organizationsUrl = "organizations_url"
    static let reposUrl = "repos_url"
    static let htmlUrl = "html_url"
    static let siteAdmin = "site_admin"
    static let gravatarId = "gravatar_id"
    static let starredUrl = "starred_url"
    static let avatarUrl = "avatar_url"
    static let type = "type"
    static let gistsUrl = "gists_url"
    static let login = "login"
    static let followersUrl = "followers_url"
    static let id = "id"
    static let subscriptionsUrl = "subscriptions_url"
    static let followingUrl = "following_url"
    static let receivedEventsUrl = "received_events_url"
    static let eventsUrl = "events_url"
    static let url = "url"
  }

  // MARK: Properties
  public var organizationsUrl: String?
  public var reposUrl: String?
  public var htmlUrl: String?
  public var siteAdmin: Bool? = false
  public var gravatarId: String?
  public var starredUrl: String?
  public var avatarUrl: String?
  public var type: String?
  public var gistsUrl: String?
  public var login: String?
  public var followersUrl: String?
  public var id: Int?
  public var subscriptionsUrl: String?
  public var followingUrl: String?
  public var receivedEventsUrl: String?
  public var eventsUrl: String?
  public var url: String?

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
    organizationsUrl = json[SerializationKeys.organizationsUrl].string
    reposUrl = json[SerializationKeys.reposUrl].string
    htmlUrl = json[SerializationKeys.htmlUrl].string
    siteAdmin = json[SerializationKeys.siteAdmin].boolValue
    gravatarId = json[SerializationKeys.gravatarId].string
    starredUrl = json[SerializationKeys.starredUrl].string
    avatarUrl = json[SerializationKeys.avatarUrl].string
    type = json[SerializationKeys.type].string
    gistsUrl = json[SerializationKeys.gistsUrl].string
    login = json[SerializationKeys.login].string
    followersUrl = json[SerializationKeys.followersUrl].string
    id = json[SerializationKeys.id].int
    subscriptionsUrl = json[SerializationKeys.subscriptionsUrl].string
    followingUrl = json[SerializationKeys.followingUrl].string
    receivedEventsUrl = json[SerializationKeys.receivedEventsUrl].string
    eventsUrl = json[SerializationKeys.eventsUrl].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = organizationsUrl { dictionary[SerializationKeys.organizationsUrl] = value }
    if let value = reposUrl { dictionary[SerializationKeys.reposUrl] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    dictionary[SerializationKeys.siteAdmin] = siteAdmin
    if let value = gravatarId { dictionary[SerializationKeys.gravatarId] = value }
    if let value = starredUrl { dictionary[SerializationKeys.starredUrl] = value }
    if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = gistsUrl { dictionary[SerializationKeys.gistsUrl] = value }
    if let value = login { dictionary[SerializationKeys.login] = value }
    if let value = followersUrl { dictionary[SerializationKeys.followersUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = subscriptionsUrl { dictionary[SerializationKeys.subscriptionsUrl] = value }
    if let value = followingUrl { dictionary[SerializationKeys.followingUrl] = value }
    if let value = receivedEventsUrl { dictionary[SerializationKeys.receivedEventsUrl] = value }
    if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.organizationsUrl = aDecoder.decodeObject(forKey: SerializationKeys.organizationsUrl) as? String
    self.reposUrl = aDecoder.decodeObject(forKey: SerializationKeys.reposUrl) as? String
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.siteAdmin = aDecoder.decodeBool(forKey: SerializationKeys.siteAdmin)
    self.gravatarId = aDecoder.decodeObject(forKey: SerializationKeys.gravatarId) as? String
    self.starredUrl = aDecoder.decodeObject(forKey: SerializationKeys.starredUrl) as? String
    self.avatarUrl = aDecoder.decodeObject(forKey: SerializationKeys.avatarUrl) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.gistsUrl = aDecoder.decodeObject(forKey: SerializationKeys.gistsUrl) as? String
    self.login = aDecoder.decodeObject(forKey: SerializationKeys.login) as? String
    self.followersUrl = aDecoder.decodeObject(forKey: SerializationKeys.followersUrl) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.subscriptionsUrl = aDecoder.decodeObject(forKey: SerializationKeys.subscriptionsUrl) as? String
    self.followingUrl = aDecoder.decodeObject(forKey: SerializationKeys.followingUrl) as? String
    self.receivedEventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.receivedEventsUrl) as? String
    self.eventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.eventsUrl) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(organizationsUrl, forKey: SerializationKeys.organizationsUrl)
    aCoder.encode(reposUrl, forKey: SerializationKeys.reposUrl)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(siteAdmin, forKey: SerializationKeys.siteAdmin)
    aCoder.encode(gravatarId, forKey: SerializationKeys.gravatarId)
    aCoder.encode(starredUrl, forKey: SerializationKeys.starredUrl)
    aCoder.encode(avatarUrl, forKey: SerializationKeys.avatarUrl)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(gistsUrl, forKey: SerializationKeys.gistsUrl)
    aCoder.encode(login, forKey: SerializationKeys.login)
    aCoder.encode(followersUrl, forKey: SerializationKeys.followersUrl)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(subscriptionsUrl, forKey: SerializationKeys.subscriptionsUrl)
    aCoder.encode(followingUrl, forKey: SerializationKeys.followingUrl)
    aCoder.encode(receivedEventsUrl, forKey: SerializationKeys.receivedEventsUrl)
    aCoder.encode(eventsUrl, forKey: SerializationKeys.eventsUrl)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
