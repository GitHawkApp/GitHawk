//
//  Issue.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Issue: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let labels = "labels"
    static let user = "user"
    static let updatedAt = "updated_at"
    static let htmlUrl = "html_url"
    static let body = "body"
    static let closedAt = "closed_at"
    static let href = "href"
    static let locked = "locked"
    static let number = "number"
    static let milestone = "milestone"
    static let labelsUrl = "labels_url"
    static let id = "id"
    static let pullRequest = "pull_request"
    static let repository = "repository"
    static let createdAt = "created_at"
    static let comments = "comments"
    static let title = "title"
    static let commentsUrl = "comments_url"
    static let assignee = "assignee"
    static let eventsUrl = "events_url"
    static let url = "url"
    static let repositoryUrl = "repository_url"
  }

  // MARK: Properties
  public var state: String?
  public var labels: [Labels]?
  public var user: User?
  public var updatedAt: String?
  public var htmlUrl: String?
  public var body: String?
  public var closedAt: String?
  public var href: String?
  public var locked: Bool? = false
  public var number: Int?
  public var milestone: Milestone?
  public var labelsUrl: String?
  public var id: Int?
  public var pullRequest: PullRequest?
  public var repository: Repository?
  public var createdAt: String?
  public var comments: Int?
  public var title: String?
  public var commentsUrl: String?
  public var assignee: Assignee?
  public var eventsUrl: String?
  public var url: String?
  public var repositoryUrl: String?

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
    if let items = json[SerializationKeys.labels].array { labels = items.map { Labels(json: $0) } }
    user = User(json: json[SerializationKeys.user])
    updatedAt = json[SerializationKeys.updatedAt].string
    htmlUrl = json[SerializationKeys.htmlUrl].string
    body = json[SerializationKeys.body].string
    closedAt = json[SerializationKeys.closedAt].string
    href = json[SerializationKeys.href].string
    locked = json[SerializationKeys.locked].boolValue
    number = json[SerializationKeys.number].int
    milestone = Milestone(json: json[SerializationKeys.milestone])
    labelsUrl = json[SerializationKeys.labelsUrl].string
    id = json[SerializationKeys.id].int
    pullRequest = PullRequest(json: json[SerializationKeys.pullRequest])
    repository = Repository(json: json[SerializationKeys.repository])
    createdAt = json[SerializationKeys.createdAt].string
    comments = json[SerializationKeys.comments].int
    title = json[SerializationKeys.title].string
    commentsUrl = json[SerializationKeys.commentsUrl].string
    assignee = Assignee(json: json[SerializationKeys.assignee])
    eventsUrl = json[SerializationKeys.eventsUrl].string
    url = json[SerializationKeys.url].string
    repositoryUrl = json[SerializationKeys.repositoryUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = labels { dictionary[SerializationKeys.labels] = value.map { $0.dictionaryRepresentation() } }
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    if let value = body { dictionary[SerializationKeys.body] = value }
    if let value = closedAt { dictionary[SerializationKeys.closedAt] = value }
    if let value = href { dictionary[SerializationKeys.href] = value }
    dictionary[SerializationKeys.locked] = locked
    if let value = number { dictionary[SerializationKeys.number] = value }
    if let value = milestone { dictionary[SerializationKeys.milestone] = value.dictionaryRepresentation() }
    if let value = labelsUrl { dictionary[SerializationKeys.labelsUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = pullRequest { dictionary[SerializationKeys.pullRequest] = value.dictionaryRepresentation() }
    if let value = repository { dictionary[SerializationKeys.repository] = value.dictionaryRepresentation() }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = comments { dictionary[SerializationKeys.comments] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = commentsUrl { dictionary[SerializationKeys.commentsUrl] = value }
    if let value = assignee { dictionary[SerializationKeys.assignee] = value.dictionaryRepresentation() }
    if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = repositoryUrl { dictionary[SerializationKeys.repositoryUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.labels = aDecoder.decodeObject(forKey: SerializationKeys.labels) as? [Labels]
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.body = aDecoder.decodeObject(forKey: SerializationKeys.body) as? String
    self.closedAt = aDecoder.decodeObject(forKey: SerializationKeys.closedAt) as? String
    self.href = aDecoder.decodeObject(forKey: SerializationKeys.href) as? String
    self.locked = aDecoder.decodeBool(forKey: SerializationKeys.locked)
    self.number = aDecoder.decodeObject(forKey: SerializationKeys.number) as? Int
    self.milestone = aDecoder.decodeObject(forKey: SerializationKeys.milestone) as? Milestone
    self.labelsUrl = aDecoder.decodeObject(forKey: SerializationKeys.labelsUrl) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.pullRequest = aDecoder.decodeObject(forKey: SerializationKeys.pullRequest) as? PullRequest
    self.repository = aDecoder.decodeObject(forKey: SerializationKeys.repository) as? Repository
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.comments = aDecoder.decodeObject(forKey: SerializationKeys.comments) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.commentsUrl = aDecoder.decodeObject(forKey: SerializationKeys.commentsUrl) as? String
    self.assignee = aDecoder.decodeObject(forKey: SerializationKeys.assignee) as? Assignee
    self.eventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.eventsUrl) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.repositoryUrl = aDecoder.decodeObject(forKey: SerializationKeys.repositoryUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(labels, forKey: SerializationKeys.labels)
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(body, forKey: SerializationKeys.body)
    aCoder.encode(closedAt, forKey: SerializationKeys.closedAt)
    aCoder.encode(href, forKey: SerializationKeys.href)
    aCoder.encode(locked, forKey: SerializationKeys.locked)
    aCoder.encode(number, forKey: SerializationKeys.number)
    aCoder.encode(milestone, forKey: SerializationKeys.milestone)
    aCoder.encode(labelsUrl, forKey: SerializationKeys.labelsUrl)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(pullRequest, forKey: SerializationKeys.pullRequest)
    aCoder.encode(repository, forKey: SerializationKeys.repository)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(comments, forKey: SerializationKeys.comments)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(commentsUrl, forKey: SerializationKeys.commentsUrl)
    aCoder.encode(assignee, forKey: SerializationKeys.assignee)
    aCoder.encode(eventsUrl, forKey: SerializationKeys.eventsUrl)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(repositoryUrl, forKey: SerializationKeys.repositoryUrl)
  }

}
