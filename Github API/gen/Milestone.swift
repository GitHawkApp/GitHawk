//
//  Milestone.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Milestone: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let updatedAt = "updated_at"
    static let openIssues = "open_issues"
    static let htmlUrl = "html_url"
    static let closedAt = "closed_at"
    static let descriptionValue = "description"
    static let number = "number"
    static let creator = "creator"
    static let labelsUrl = "labels_url"
    static let id = "id"
    static let closedIssues = "closed_issues"
    static let createdAt = "created_at"
    static let title = "title"
    static let dueOn = "due_on"
    static let url = "url"
  }

  // MARK: Properties
  public var state: String?
  public var updatedAt: String?
  public var openIssues: Int?
  public var htmlUrl: String?
  public var closedAt: String?
  public var descriptionValue: String?
  public var number: Int?
  public var creator: Creator?
  public var labelsUrl: String?
  public var id: Int?
  public var closedIssues: Int?
  public var createdAt: String?
  public var title: String?
  public var dueOn: String?
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
    state = json[SerializationKeys.state].string
    updatedAt = json[SerializationKeys.updatedAt].string
    openIssues = json[SerializationKeys.openIssues].int
    htmlUrl = json[SerializationKeys.htmlUrl].string
    closedAt = json[SerializationKeys.closedAt].string
    descriptionValue = json[SerializationKeys.descriptionValue].string
    number = json[SerializationKeys.number].int
    creator = Creator(json: json[SerializationKeys.creator])
    labelsUrl = json[SerializationKeys.labelsUrl].string
    id = json[SerializationKeys.id].int
    closedIssues = json[SerializationKeys.closedIssues].int
    createdAt = json[SerializationKeys.createdAt].string
    title = json[SerializationKeys.title].string
    dueOn = json[SerializationKeys.dueOn].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = openIssues { dictionary[SerializationKeys.openIssues] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    if let value = closedAt { dictionary[SerializationKeys.closedAt] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = number { dictionary[SerializationKeys.number] = value }
    if let value = creator { dictionary[SerializationKeys.creator] = value.dictionaryRepresentation() }
    if let value = labelsUrl { dictionary[SerializationKeys.labelsUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = closedIssues { dictionary[SerializationKeys.closedIssues] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = dueOn { dictionary[SerializationKeys.dueOn] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.openIssues = aDecoder.decodeObject(forKey: SerializationKeys.openIssues) as? Int
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.closedAt = aDecoder.decodeObject(forKey: SerializationKeys.closedAt) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.number = aDecoder.decodeObject(forKey: SerializationKeys.number) as? Int
    self.creator = aDecoder.decodeObject(forKey: SerializationKeys.creator) as? Creator
    self.labelsUrl = aDecoder.decodeObject(forKey: SerializationKeys.labelsUrl) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.closedIssues = aDecoder.decodeObject(forKey: SerializationKeys.closedIssues) as? Int
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.dueOn = aDecoder.decodeObject(forKey: SerializationKeys.dueOn) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(openIssues, forKey: SerializationKeys.openIssues)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(closedAt, forKey: SerializationKeys.closedAt)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(number, forKey: SerializationKeys.number)
    aCoder.encode(creator, forKey: SerializationKeys.creator)
    aCoder.encode(labelsUrl, forKey: SerializationKeys.labelsUrl)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(closedIssues, forKey: SerializationKeys.closedIssues)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(dueOn, forKey: SerializationKeys.dueOn)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
