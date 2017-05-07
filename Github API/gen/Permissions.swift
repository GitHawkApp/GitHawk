//
//  Permissions.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Permissions: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let push = "push"
    static let admin = "admin"
    static let pull = "pull"
  }

  // MARK: Properties
  public var push: Bool? = false
  public var admin: Bool? = false
  public var pull: Bool? = false

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
    push = json[SerializationKeys.push].boolValue
    admin = json[SerializationKeys.admin].boolValue
    pull = json[SerializationKeys.pull].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.push] = push
    dictionary[SerializationKeys.admin] = admin
    dictionary[SerializationKeys.pull] = pull
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.push = aDecoder.decodeBool(forKey: SerializationKeys.push)
    self.admin = aDecoder.decodeBool(forKey: SerializationKeys.admin)
    self.pull = aDecoder.decodeBool(forKey: SerializationKeys.pull)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(push, forKey: SerializationKeys.push)
    aCoder.encode(admin, forKey: SerializationKeys.admin)
    aCoder.encode(pull, forKey: SerializationKeys.pull)
  }

}
