//
//  Notification.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Notification: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reason = "reason"
    static let updatedAt = "updated_at"
    static let unread = "unread"
    static let id = "id"
    static let repository = "repository"
    static let lastReadAt = "last_read_at"
    static let url = "url"
    static let subject = "subject"
  }

  // MARK: Properties
  public var reason: String?
  public var updatedAt: String?
  public var unread: Bool? = false
  public var id: String?
  public var repository: Repository?
  public var lastReadAt: String?
  public var url: String?
  public var subject: Subject?

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
    reason = json[SerializationKeys.reason].string
    updatedAt = json[SerializationKeys.updatedAt].string
    unread = json[SerializationKeys.unread].boolValue
    id = json[SerializationKeys.id].string
    repository = Repository(json: json[SerializationKeys.repository])
    lastReadAt = json[SerializationKeys.lastReadAt].string
    url = json[SerializationKeys.url].string
    subject = Subject(json: json[SerializationKeys.subject])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reason { dictionary[SerializationKeys.reason] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    dictionary[SerializationKeys.unread] = unread
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = repository { dictionary[SerializationKeys.repository] = value.dictionaryRepresentation() }
    if let value = lastReadAt { dictionary[SerializationKeys.lastReadAt] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = subject { dictionary[SerializationKeys.subject] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.reason = aDecoder.decodeObject(forKey: SerializationKeys.reason) as? String
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.unread = aDecoder.decodeBool(forKey: SerializationKeys.unread)
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.repository = aDecoder.decodeObject(forKey: SerializationKeys.repository) as? Repository
    self.lastReadAt = aDecoder.decodeObject(forKey: SerializationKeys.lastReadAt) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.subject = aDecoder.decodeObject(forKey: SerializationKeys.subject) as? Subject
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(reason, forKey: SerializationKeys.reason)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(unread, forKey: SerializationKeys.unread)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(repository, forKey: SerializationKeys.repository)
    aCoder.encode(lastReadAt, forKey: SerializationKeys.lastReadAt)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(subject, forKey: SerializationKeys.subject)
  }

}
