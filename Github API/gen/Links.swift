//
//  Links.swift
//
//  Created by Ryan Nystrom on 5/4/17
//  Copyright (c) Ryan Nystrom. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Links: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reviewComments = "review_comments"
    static let statuses = "statuses"
    static let issue = "issue"
    static let commits = "commits"
    static let self = "self"
    static let comments = "comments"
    static let html = "html"
    static let reviewComment = "review_comment"
  }

  // MARK: Properties
  public var reviewComments: ReviewComments?
  public var statuses: Statuses?
  public var issue: Issue?
  public var commits: Commits?
  public var self: Self?
  public var comments: Comments?
  public var html: Html?
  public var reviewComment: ReviewComment?

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
    reviewComments = ReviewComments(json: json[SerializationKeys.reviewComments])
    statuses = Statuses(json: json[SerializationKeys.statuses])
    issue = Issue(json: json[SerializationKeys.issue])
    commits = Commits(json: json[SerializationKeys.commits])
    self = Self(json: json[SerializationKeys.self])
    comments = Comments(json: json[SerializationKeys.comments])
    html = Html(json: json[SerializationKeys.html])
    reviewComment = ReviewComment(json: json[SerializationKeys.reviewComment])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reviewComments { dictionary[SerializationKeys.reviewComments] = value.dictionaryRepresentation() }
    if let value = statuses { dictionary[SerializationKeys.statuses] = value.dictionaryRepresentation() }
    if let value = issue { dictionary[SerializationKeys.issue] = value.dictionaryRepresentation() }
    if let value = commits { dictionary[SerializationKeys.commits] = value.dictionaryRepresentation() }
    if let value = self { dictionary[SerializationKeys.self] = value.dictionaryRepresentation() }
    if let value = comments { dictionary[SerializationKeys.comments] = value.dictionaryRepresentation() }
    if let value = html { dictionary[SerializationKeys.html] = value.dictionaryRepresentation() }
    if let value = reviewComment { dictionary[SerializationKeys.reviewComment] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.reviewComments = aDecoder.decodeObject(forKey: SerializationKeys.reviewComments) as? ReviewComments
    self.statuses = aDecoder.decodeObject(forKey: SerializationKeys.statuses) as? Statuses
    self.issue = aDecoder.decodeObject(forKey: SerializationKeys.issue) as? Issue
    self.commits = aDecoder.decodeObject(forKey: SerializationKeys.commits) as? Commits
    self.self = aDecoder.decodeObject(forKey: SerializationKeys.self) as? Self
    self.comments = aDecoder.decodeObject(forKey: SerializationKeys.comments) as? Comments
    self.html = aDecoder.decodeObject(forKey: SerializationKeys.html) as? Html
    self.reviewComment = aDecoder.decodeObject(forKey: SerializationKeys.reviewComment) as? ReviewComment
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(reviewComments, forKey: SerializationKeys.reviewComments)
    aCoder.encode(statuses, forKey: SerializationKeys.statuses)
    aCoder.encode(issue, forKey: SerializationKeys.issue)
    aCoder.encode(commits, forKey: SerializationKeys.commits)
    aCoder.encode(self, forKey: SerializationKeys.self)
    aCoder.encode(comments, forKey: SerializationKeys.comments)
    aCoder.encode(html, forKey: SerializationKeys.html)
    aCoder.encode(reviewComment, forKey: SerializationKeys.reviewComment)
  }

}
