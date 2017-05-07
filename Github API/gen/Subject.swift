//
//  Subject.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Subject: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let type = "type"
    static let latestCommentUrl = "latest_comment_url"
    static let url = "url"
  }

  // MARK: Properties
  public var title: String?
  public var type: String?
  public var latestCommentUrl: String?
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
    title = json[SerializationKeys.title].string
    type = json[SerializationKeys.type].string
    latestCommentUrl = json[SerializationKeys.latestCommentUrl].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = latestCommentUrl { dictionary[SerializationKeys.latestCommentUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.latestCommentUrl = aDecoder.decodeObject(forKey: SerializationKeys.latestCommentUrl) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(latestCommentUrl, forKey: SerializationKeys.latestCommentUrl)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
