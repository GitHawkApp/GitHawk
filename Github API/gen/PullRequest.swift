//
//  PullRequest.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PullRequest: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let body = "body"
    static let closedAt = "closed_at"
    static let links = "_links"
    static let diffUrl = "diff_url"
    static let locked = "locked"
    static let patchUrl = "patch_url"
    static let milestone = "milestone"
    static let statusesUrl = "statuses_url"
    static let id = "id"
    static let reviewCommentUrl = "review_comment_url"
    static let base = "base"
    static let title = "title"
    static let commentsUrl = "comments_url"
    static let url = "url"
    static let issueUrl = "issue_url"
    static let user = "user"
    static let updatedAt = "updated_at"
    static let htmlUrl = "html_url"
    static let mergedAt = "merged_at"
    static let number = "number"
    static let head = "head"
    static let commitsUrl = "commits_url"
    static let createdAt = "created_at"
    static let assignee = "assignee"
    static let reviewCommentsUrl = "review_comments_url"
  }

  // MARK: Properties
  public var state: String?
  public var body: String?
  public var closedAt: String?
  public var links: Links?
  public var diffUrl: String?
  public var locked: Bool? = false
  public var patchUrl: String?
  public var milestone: Milestone?
  public var statusesUrl: String?
  public var id: Int?
  public var reviewCommentUrl: String?
  public var base: Base?
  public var title: String?
  public var commentsUrl: String?
  public var url: String?
  public var issueUrl: String?
  public var user: User?
  public var updatedAt: String?
  public var htmlUrl: String?
  public var mergedAt: String?
  public var number: Int?
  public var head: Head?
  public var commitsUrl: String?
  public var createdAt: String?
  public var assignee: Assignee?
  public var reviewCommentsUrl: String?

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
    body = json[SerializationKeys.body].string
    closedAt = json[SerializationKeys.closedAt].string
    links = Links(json: json[SerializationKeys.links])
    diffUrl = json[SerializationKeys.diffUrl].string
    locked = json[SerializationKeys.locked].boolValue
    patchUrl = json[SerializationKeys.patchUrl].string
    milestone = Milestone(json: json[SerializationKeys.milestone])
    statusesUrl = json[SerializationKeys.statusesUrl].string
    id = json[SerializationKeys.id].int
    reviewCommentUrl = json[SerializationKeys.reviewCommentUrl].string
    base = Base(json: json[SerializationKeys.base])
    title = json[SerializationKeys.title].string
    commentsUrl = json[SerializationKeys.commentsUrl].string
    url = json[SerializationKeys.url].string
    issueUrl = json[SerializationKeys.issueUrl].string
    user = User(json: json[SerializationKeys.user])
    updatedAt = json[SerializationKeys.updatedAt].string
    htmlUrl = json[SerializationKeys.htmlUrl].string
    mergedAt = json[SerializationKeys.mergedAt].string
    number = json[SerializationKeys.number].int
    head = Head(json: json[SerializationKeys.head])
    commitsUrl = json[SerializationKeys.commitsUrl].string
    createdAt = json[SerializationKeys.createdAt].string
    assignee = Assignee(json: json[SerializationKeys.assignee])
    reviewCommentsUrl = json[SerializationKeys.reviewCommentsUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = body { dictionary[SerializationKeys.body] = value }
    if let value = closedAt { dictionary[SerializationKeys.closedAt] = value }
    if let value = links { dictionary[SerializationKeys.links] = value.dictionaryRepresentation() }
    if let value = diffUrl { dictionary[SerializationKeys.diffUrl] = value }
    dictionary[SerializationKeys.locked] = locked
    if let value = patchUrl { dictionary[SerializationKeys.patchUrl] = value }
    if let value = milestone { dictionary[SerializationKeys.milestone] = value.dictionaryRepresentation() }
    if let value = statusesUrl { dictionary[SerializationKeys.statusesUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = reviewCommentUrl { dictionary[SerializationKeys.reviewCommentUrl] = value }
    if let value = base { dictionary[SerializationKeys.base] = value.dictionaryRepresentation() }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = commentsUrl { dictionary[SerializationKeys.commentsUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = issueUrl { dictionary[SerializationKeys.issueUrl] = value }
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    if let value = mergedAt { dictionary[SerializationKeys.mergedAt] = value }
    if let value = number { dictionary[SerializationKeys.number] = value }
    if let value = head { dictionary[SerializationKeys.head] = value.dictionaryRepresentation() }
    if let value = commitsUrl { dictionary[SerializationKeys.commitsUrl] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = assignee { dictionary[SerializationKeys.assignee] = value.dictionaryRepresentation() }
    if let value = reviewCommentsUrl { dictionary[SerializationKeys.reviewCommentsUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.body = aDecoder.decodeObject(forKey: SerializationKeys.body) as? String
    self.closedAt = aDecoder.decodeObject(forKey: SerializationKeys.closedAt) as? String
    self.links = aDecoder.decodeObject(forKey: SerializationKeys.links) as? Links
    self.diffUrl = aDecoder.decodeObject(forKey: SerializationKeys.diffUrl) as? String
    self.locked = aDecoder.decodeBool(forKey: SerializationKeys.locked)
    self.patchUrl = aDecoder.decodeObject(forKey: SerializationKeys.patchUrl) as? String
    self.milestone = aDecoder.decodeObject(forKey: SerializationKeys.milestone) as? Milestone
    self.statusesUrl = aDecoder.decodeObject(forKey: SerializationKeys.statusesUrl) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.reviewCommentUrl = aDecoder.decodeObject(forKey: SerializationKeys.reviewCommentUrl) as? String
    self.base = aDecoder.decodeObject(forKey: SerializationKeys.base) as? Base
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.commentsUrl = aDecoder.decodeObject(forKey: SerializationKeys.commentsUrl) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.issueUrl = aDecoder.decodeObject(forKey: SerializationKeys.issueUrl) as? String
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
    self.mergedAt = aDecoder.decodeObject(forKey: SerializationKeys.mergedAt) as? String
    self.number = aDecoder.decodeObject(forKey: SerializationKeys.number) as? Int
    self.head = aDecoder.decodeObject(forKey: SerializationKeys.head) as? Head
    self.commitsUrl = aDecoder.decodeObject(forKey: SerializationKeys.commitsUrl) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.assignee = aDecoder.decodeObject(forKey: SerializationKeys.assignee) as? Assignee
    self.reviewCommentsUrl = aDecoder.decodeObject(forKey: SerializationKeys.reviewCommentsUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(body, forKey: SerializationKeys.body)
    aCoder.encode(closedAt, forKey: SerializationKeys.closedAt)
    aCoder.encode(links, forKey: SerializationKeys.links)
    aCoder.encode(diffUrl, forKey: SerializationKeys.diffUrl)
    aCoder.encode(locked, forKey: SerializationKeys.locked)
    aCoder.encode(patchUrl, forKey: SerializationKeys.patchUrl)
    aCoder.encode(milestone, forKey: SerializationKeys.milestone)
    aCoder.encode(statusesUrl, forKey: SerializationKeys.statusesUrl)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(reviewCommentUrl, forKey: SerializationKeys.reviewCommentUrl)
    aCoder.encode(base, forKey: SerializationKeys.base)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(commentsUrl, forKey: SerializationKeys.commentsUrl)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(issueUrl, forKey: SerializationKeys.issueUrl)
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
    aCoder.encode(mergedAt, forKey: SerializationKeys.mergedAt)
    aCoder.encode(number, forKey: SerializationKeys.number)
    aCoder.encode(head, forKey: SerializationKeys.head)
    aCoder.encode(commitsUrl, forKey: SerializationKeys.commitsUrl)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(assignee, forKey: SerializationKeys.assignee)
    aCoder.encode(reviewCommentsUrl, forKey: SerializationKeys.reviewCommentsUrl)
  }

}
