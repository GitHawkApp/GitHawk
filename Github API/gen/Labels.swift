//
//  Labels.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Labels: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let defaultValue = "default"
    static let name = "name"
    static let id = "id"
    static let url = "url"
    static let color = "color"
  }

  // MARK: Properties
  public var defaultValue: Bool? = false
  public var name: String?
  public var id: Int?
  public var url: String?
  public var color: String?

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
    defaultValue = json[SerializationKeys.defaultValue].boolValue
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].int
    url = json[SerializationKeys.url].string
    color = json[SerializationKeys.color].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.defaultValue] = defaultValue
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = color { dictionary[SerializationKeys.color] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.defaultValue = aDecoder.decodeBool(forKey: SerializationKeys.defaultValue)
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.color = aDecoder.decodeObject(forKey: SerializationKeys.color) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(defaultValue, forKey: SerializationKeys.defaultValue)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(color, forKey: SerializationKeys.color)
  }

}
