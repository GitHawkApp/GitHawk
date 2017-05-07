//
//  Base.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Base: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let label = "label"
    static let user = "user"
    static let repo = "repo"
    static let ref = "ref"
    static let sha = "sha"
  }

  // MARK: Properties
  public var label: String?
  public var user: User?
  public var repo: Repo?
  public var ref: String?
  public var sha: String?

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
    label = json[SerializationKeys.label].string
    user = User(json: json[SerializationKeys.user])
    repo = Repo(json: json[SerializationKeys.repo])
    ref = json[SerializationKeys.ref].string
    sha = json[SerializationKeys.sha].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = label { dictionary[SerializationKeys.label] = value }
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = repo { dictionary[SerializationKeys.repo] = value.dictionaryRepresentation() }
    if let value = ref { dictionary[SerializationKeys.ref] = value }
    if let value = sha { dictionary[SerializationKeys.sha] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.label = aDecoder.decodeObject(forKey: SerializationKeys.label) as? String
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
    self.repo = aDecoder.decodeObject(forKey: SerializationKeys.repo) as? Repo
    self.ref = aDecoder.decodeObject(forKey: SerializationKeys.ref) as? String
    self.sha = aDecoder.decodeObject(forKey: SerializationKeys.sha) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(label, forKey: SerializationKeys.label)
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(repo, forKey: SerializationKeys.repo)
    aCoder.encode(ref, forKey: SerializationKeys.ref)
    aCoder.encode(sha, forKey: SerializationKeys.sha)
  }

}
