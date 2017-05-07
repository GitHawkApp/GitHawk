//
//  Reactions.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Reactions: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let laugh = "laugh"
    static let hooray = "hooray"
    static let totalCount = "total_count"
    static let heart = "heart"
    static let +1 = "+1"
    static let 1 = "-1"
    static let confused = "confused"
    static let url = "url"
  }

  // MARK: Properties
  public var laugh: Int?
  public var hooray: Int?
  public var totalCount: Int?
  public var heart: Int?
  public var +1: Int?
  public var 1: Int?
  public var confused: Int?
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
    laugh = json[SerializationKeys.laugh].int
    hooray = json[SerializationKeys.hooray].int
    totalCount = json[SerializationKeys.totalCount].int
    heart = json[SerializationKeys.heart].int
    +1 = json[SerializationKeys.+1].int
    1 = json[SerializationKeys.1].int
    confused = json[SerializationKeys.confused].int
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = laugh { dictionary[SerializationKeys.laugh] = value }
    if let value = hooray { dictionary[SerializationKeys.hooray] = value }
    if let value = totalCount { dictionary[SerializationKeys.totalCount] = value }
    if let value = heart { dictionary[SerializationKeys.heart] = value }
    if let value = +1 { dictionary[SerializationKeys.+1] = value }
    if let value = 1 { dictionary[SerializationKeys.1] = value }
    if let value = confused { dictionary[SerializationKeys.confused] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.laugh = aDecoder.decodeObject(forKey: SerializationKeys.laugh) as? Int
    self.hooray = aDecoder.decodeObject(forKey: SerializationKeys.hooray) as? Int
    self.totalCount = aDecoder.decodeObject(forKey: SerializationKeys.totalCount) as? Int
    self.heart = aDecoder.decodeObject(forKey: SerializationKeys.heart) as? Int
    self.+1 = aDecoder.decodeObject(forKey: SerializationKeys.+1) as? Int
    self.1 = aDecoder.decodeObject(forKey: SerializationKeys.1) as? Int
    self.confused = aDecoder.decodeObject(forKey: SerializationKeys.confused) as? Int
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(laugh, forKey: SerializationKeys.laugh)
    aCoder.encode(hooray, forKey: SerializationKeys.hooray)
    aCoder.encode(totalCount, forKey: SerializationKeys.totalCount)
    aCoder.encode(heart, forKey: SerializationKeys.heart)
    aCoder.encode(+1, forKey: SerializationKeys.+1)
    aCoder.encode(1, forKey: SerializationKeys.1)
    aCoder.encode(confused, forKey: SerializationKeys.confused)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
