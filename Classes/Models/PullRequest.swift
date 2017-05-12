import Foundation
final class PullRequest: NSObject, NSCoding {
  struct Keys {
    static let state = "state"
    static let body = "body"
    static let closed_at = "closed_at"
    static let _links = "_links"
    static let diff_url = "diff_url"
    static let locked = "locked"
    static let patch_url = "patch_url"
    static let milestone = "milestone"
    static let statuses_url = "statuses_url"
    static let id = "id"
    static let review_comment_url = "review_comment_url"
    static let base = "base"
    static let title = "title"
    static let comments_url = "comments_url"
    static let url = "url"
    static let issue_url = "issue_url"
    static let user = "user"
    static let updated_at = "updated_at"
    static let html_url = "html_url"
    static let merged_at = "merged_at"
    static let number = "number"
    static let head = "head"
    static let commits_url = "commits_url"
    static let created_at = "created_at"
    static let assignee = "assignee"
    static let review_comments_url = "review_comments_url"
  }
  let state: String?
  let body: String?
  let closed_at: String?
  let _links: Link?
  let diff_url: String
  let locked: Bool?
  let patch_url: String
  let milestone: Milestone?
  let statuses_url: String?
  let id: NSNumber?
  let review_comment_url: String?
  let base: Branch?
  let title: String?
  let comments_url: String?
  let url: String
  let issue_url: String?
  let user: User?
  let updated_at: String?
  let html_url: String
  let merged_at: String?
  let number: NSNumber?
  let head: Branch?
  let commits_url: String?
  let created_at: String?
  let assignee: User?
  let review_comments_url: String?
  convenience init?(json: [String: Any]?) {
    let state = json?[Keys.state] as? String
    let body = json?[Keys.body] as? String
    let closed_at = json?[Keys.closed_at] as? String
    let _linksJSON = json?[Keys._links] as? [String: Any]
    let _links = Link(json: _linksJSON)
    guard let diff_url = json?[Keys.diff_url] as? String else { return nil }
    let locked = json?[Keys.locked] as? Bool
    guard let patch_url = json?[Keys.patch_url] as? String else { return nil }
    let milestoneJSON = json?[Keys.milestone] as? [String: Any]
    let milestone = Milestone(json: milestoneJSON)
    let statuses_url = json?[Keys.statuses_url] as? String
    let id = json?[Keys.id] as? NSNumber
    let review_comment_url = json?[Keys.review_comment_url] as? String
    let baseJSON = json?[Keys.base] as? [String: Any]
    let base = Branch(json: baseJSON)
    let title = json?[Keys.title] as? String
    let comments_url = json?[Keys.comments_url] as? String
    guard let url = json?[Keys.url] as? String else { return nil }
    let issue_url = json?[Keys.issue_url] as? String
    let userJSON = json?[Keys.user] as? [String: Any]
    let user = User(json: userJSON)
    let updated_at = json?[Keys.updated_at] as? String
    guard let html_url = json?[Keys.html_url] as? String else { return nil }
    let merged_at = json?[Keys.merged_at] as? String
    let number = json?[Keys.number] as? NSNumber
    let headJSON = json?[Keys.head] as? [String: Any]
    let head = Branch(json: headJSON)
    let commits_url = json?[Keys.commits_url] as? String
    let created_at = json?[Keys.created_at] as? String
    let assigneeJSON = json?[Keys.assignee] as? [String: Any]
    let assignee = User(json: assigneeJSON)
    let review_comments_url = json?[Keys.review_comments_url] as? String
    self.init(
      state: state,
      body: body,
      closed_at: closed_at,
      _links: _links,
      diff_url: diff_url,
      locked: locked,
      patch_url: patch_url,
      milestone: milestone,
      statuses_url: statuses_url,
      id: id,
      review_comment_url: review_comment_url,
      base: base,
      title: title,
      comments_url: comments_url,
      url: url,
      issue_url: issue_url,
      user: user,
      updated_at: updated_at,
      html_url: html_url,
      merged_at: merged_at,
      number: number,
      head: head,
      commits_url: commits_url,
      created_at: created_at,
      assignee: assignee,
      review_comments_url: review_comments_url
    )
  }
  init(
    state: String?,
    body: String?,
    closed_at: String?,
    _links: Link?,
    diff_url: String,
    locked: Bool?,
    patch_url: String,
    milestone: Milestone?,
    statuses_url: String?,
    id: NSNumber?,
    review_comment_url: String?,
    base: Branch?,
    title: String?,
    comments_url: String?,
    url: String,
    issue_url: String?,
    user: User?,
    updated_at: String?,
    html_url: String,
    merged_at: String?,
    number: NSNumber?,
    head: Branch?,
    commits_url: String?,
    created_at: String?,
    assignee: User?,
    review_comments_url: String?
    ) {
    self.state = state
    self.body = body
    self.closed_at = closed_at
    self._links = _links
    self.diff_url = diff_url
    self.locked = locked
    self.patch_url = patch_url
    self.milestone = milestone
    self.statuses_url = statuses_url
    self.id = id
    self.review_comment_url = review_comment_url
    self.base = base
    self.title = title
    self.comments_url = comments_url
    self.url = url
    self.issue_url = issue_url
    self.user = user
    self.updated_at = updated_at
    self.html_url = html_url
    self.merged_at = merged_at
    self.number = number
    self.head = head
    self.commits_url = commits_url
    self.created_at = created_at
    self.assignee = assignee
    self.review_comments_url = review_comments_url
  }
  convenience init?(coder aDecoder: NSCoder) {
    let state = aDecoder.decodeObject(forKey: Keys.state) as? String
    let body = aDecoder.decodeObject(forKey: Keys.body) as? String
    let closed_at = aDecoder.decodeObject(forKey: Keys.closed_at) as? String
    let _links = aDecoder.decodeObject(forKey: Keys._links) as? Link
    guard let diff_url = aDecoder.decodeObject(forKey: Keys.diff_url) as? String else { return nil }
    let locked = aDecoder.decodeBool(forKey: Keys.locked)
    guard let patch_url = aDecoder.decodeObject(forKey: Keys.patch_url) as? String else { return nil }
    let milestone = aDecoder.decodeObject(forKey: Keys.milestone) as? Milestone
    let statuses_url = aDecoder.decodeObject(forKey: Keys.statuses_url) as? String
    let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber
    let review_comment_url = aDecoder.decodeObject(forKey: Keys.review_comment_url) as? String
    let base = aDecoder.decodeObject(forKey: Keys.base) as? Branch
    let title = aDecoder.decodeObject(forKey: Keys.title) as? String
    let comments_url = aDecoder.decodeObject(forKey: Keys.comments_url) as? String
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    let issue_url = aDecoder.decodeObject(forKey: Keys.issue_url) as? String
    let user = aDecoder.decodeObject(forKey: Keys.user) as? User
    let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String
    guard let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String else { return nil }
    let merged_at = aDecoder.decodeObject(forKey: Keys.merged_at) as? String
    let number = aDecoder.decodeObject(forKey: Keys.number) as? NSNumber
    let head = aDecoder.decodeObject(forKey: Keys.head) as? Branch
    let commits_url = aDecoder.decodeObject(forKey: Keys.commits_url) as? String
    let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String
    let assignee = aDecoder.decodeObject(forKey: Keys.assignee) as? User
    let review_comments_url = aDecoder.decodeObject(forKey: Keys.review_comments_url) as? String
    self.init(
      state: state,
      body: body,
      closed_at: closed_at,
      _links: _links,
      diff_url: diff_url,
      locked: locked,
      patch_url: patch_url,
      milestone: milestone,
      statuses_url: statuses_url,
      id: id,
      review_comment_url: review_comment_url,
      base: base,
      title: title,
      comments_url: comments_url,
      url: url,
      issue_url: issue_url,
      user: user,
      updated_at: updated_at,
      html_url: html_url,
      merged_at: merged_at,
      number: number,
      head: head,
      commits_url: commits_url,
      created_at: created_at,
      assignee: assignee,
      review_comments_url: review_comments_url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: Keys.state)
    aCoder.encode(body, forKey: Keys.body)
    aCoder.encode(closed_at, forKey: Keys.closed_at)
    aCoder.encode(_links, forKey: Keys._links)
    aCoder.encode(diff_url, forKey: Keys.diff_url)
    aCoder.encode(locked, forKey: Keys.locked)
    aCoder.encode(patch_url, forKey: Keys.patch_url)
    aCoder.encode(milestone, forKey: Keys.milestone)
    aCoder.encode(statuses_url, forKey: Keys.statuses_url)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(review_comment_url, forKey: Keys.review_comment_url)
    aCoder.encode(base, forKey: Keys.base)
    aCoder.encode(title, forKey: Keys.title)
    aCoder.encode(comments_url, forKey: Keys.comments_url)
    aCoder.encode(url, forKey: Keys.url)
    aCoder.encode(issue_url, forKey: Keys.issue_url)
    aCoder.encode(user, forKey: Keys.user)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(merged_at, forKey: Keys.merged_at)
    aCoder.encode(number, forKey: Keys.number)
    aCoder.encode(head, forKey: Keys.head)
    aCoder.encode(commits_url, forKey: Keys.commits_url)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(assignee, forKey: Keys.assignee)
    aCoder.encode(review_comments_url, forKey: Keys.review_comments_url)
  }
}