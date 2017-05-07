//
//  Comment.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Comment: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let user = "user"
    static let updatedAt = "updated_at"
    static let id = "id"
    static let htmlUrl = "html_url"
    static let body = "body"
    static let createdAt = "created_at"
    static let url = "url"
  }

  // MARK: Properties
  public var user: User?
  public var updatedAt: String?
  public var id: Int?
  public var htmlUrl: String?
  public var body: String?
  public var createdAt: String?
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
    user = User(json: json[SerializationKeys.user])
    updatedAt = json[SerializationKeys.updatedAt].string
    id = json[SerializationKeys.id].int
    htmlUrl = json[SerializationKeys.htmlUrl].string
    body = json[SerializationKeys.body].string
    createdAt = json[SerializationKeys.createdAt].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    if let value = body { dictionary[SerializationKeys.body] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.body = aDecoder.decodeObject(forKey: SerializationKeys.body) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(body, forKey: SerializationKeys.body)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
