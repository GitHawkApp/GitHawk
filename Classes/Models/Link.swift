import Foundation
final class Link: NSObject, NSCoding {
  struct Keys {
    static let review_comments = "review_comments"
    static let statuses = "statuses"
    static let issue = "issue"
    static let commits = "commits"
    static let self_ = "self"
    static let comments = "comments"
    static let html = "html"
    static let review_comment = "review_comment"
  }
  let review_comments: ReviewComment
  let statuses: Status
  let issue: Issue
  let commits: Commit
  let self_: Self_
  let comments: Comment
  let html: Html
  let review_comment: ReviewComment
  convenience init?(json: [String: Any]?) {
    guard let review_commentsJSON = json?[Keys.review_comments] as? [String: Any] else { return nil }
    guard let review_comments = ReviewComment(json: review_commentsJSON) else { return nil }
    guard let statusesJSON = json?[Keys.statuses] as? [String: Any] else { return nil }
    guard let statuses = Status(json: statusesJSON) else { return nil }
    guard let issueJSON = json?[Keys.issue] as? [String: Any] else { return nil }
    guard let issue = Issue(json: issueJSON) else { return nil }
    guard let commitsJSON = json?[Keys.commits] as? [String: Any] else { return nil }
    guard let commits = Commit(json: commitsJSON) else { return nil }
    guard let self_JSON = json?[Keys.self_] as? [String: Any] else { return nil }
    guard let self_ = Self_(json: self_JSON) else { return nil }
    guard let commentsJSON = json?[Keys.comments] as? [String: Any] else { return nil }
    guard let comments = Comment(json: commentsJSON) else { return nil }
    guard let htmlJSON = json?[Keys.html] as? [String: Any] else { return nil }
    guard let html = Html(json: htmlJSON) else { return nil }
    guard let review_commentJSON = json?[Keys.review_comment] as? [String: Any] else { return nil }
    guard let review_comment = ReviewComment(json: review_commentJSON) else { return nil }
    self.init(
      review_comments: review_comments,
      statuses: statuses,
      issue: issue,
      commits: commits,
      self_: self_,
      comments: comments,
      html: html,
      review_comment: review_comment
    )
  }
  init(
    review_comments: ReviewComment,
    statuses: Status,
    issue: Issue,
    commits: Commit,
    self_: Self_,
    comments: Comment,
    html: Html,
    review_comment: ReviewComment
    ) {
    self.review_comments = review_comments
    self.statuses = statuses
    self.issue = issue
    self.commits = commits
    self.self_ = self_
    self.comments = comments
    self.html = html
    self.review_comment = review_comment
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let review_comments = aDecoder.decodeObject(forKey: Keys.review_comments) as? ReviewComment else { return nil }
    guard let statuses = aDecoder.decodeObject(forKey: Keys.statuses) as? Status else { return nil }
    guard let issue = aDecoder.decodeObject(forKey: Keys.issue) as? Issue else { return nil }
    guard let commits = aDecoder.decodeObject(forKey: Keys.commits) as? Commit else { return nil }
    guard let self_ = aDecoder.decodeObject(forKey: Keys.self_) as? Self_ else { return nil }
    guard let comments = aDecoder.decodeObject(forKey: Keys.comments) as? Comment else { return nil }
    guard let html = aDecoder.decodeObject(forKey: Keys.html) as? Html else { return nil }
    guard let review_comment = aDecoder.decodeObject(forKey: Keys.review_comment) as? ReviewComment else { return nil }
    self.init(
      review_comments: review_comments,
      statuses: statuses,
      issue: issue,
      commits: commits,
      self_: self_,
      comments: comments,
      html: html,
      review_comment: review_comment
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(review_comments, forKey: Keys.review_comments)
    aCoder.encode(statuses, forKey: Keys.statuses)
    aCoder.encode(issue, forKey: Keys.issue)
    aCoder.encode(commits, forKey: Keys.commits)
    aCoder.encode(self_, forKey: Keys.self_)
    aCoder.encode(comments, forKey: Keys.comments)
    aCoder.encode(html, forKey: Keys.html)
    aCoder.encode(review_comment, forKey: Keys.review_comment)
  }
}