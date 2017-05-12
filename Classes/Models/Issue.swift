import Foundation
final class Issue: NSObject, NSCoding {
  struct Keys {
    static let state = "state"
    static let labels = "labels"
    static let user = "user"
    static let updated_at = "updated_at"
    static let html_url = "html_url"
    static let body = "body"
    static let closed_at = "closed_at"
    static let href = "href"
    static let locked = "locked"
    static let number = "number"
    static let milestone = "milestone"
    static let labels_url = "labels_url"
    static let id = "id"
    static let pull_request = "pull_request"
    static let repository = "repository"
    static let created_at = "created_at"
    static let comments = "comments"
    static let title = "title"
    static let comments_url = "comments_url"
    static let assignee = "assignee"
    static let events_url = "events_url"
    static let url = "url"
    static let repository_url = "repository_url"
  }
  let state: String?
  let labels: [Label]?
  let user: User?
  let updated_at: String?
  let html_url: String?
  let body: String?
  let closed_at: String?
  let href: String?
  let locked: Bool?
  let number: NSNumber?
  let milestone: Milestone?
  let labels_url: String?
  let id: NSNumber?
  let pull_request: PullRequest?
  let repository: Repository?
  let created_at: String?
  let comments: NSNumber?
  let title: String?
  let comments_url: String?
  let assignee: User?
  let events_url: String?
  let url: String?
  let repository_url: String?
  convenience init?(json: [String: Any]?) {
    let state = json?[Keys.state] as? String
    let labelsJSON = json?[Keys.labels] as? [ [String: Any] ]
    var labels = [Label]()
    for dict in labelsJSON ?? [] {
      if let object = Label(json: dict) {
        labels.append(object)
      }
    }
    let userJSON = json?[Keys.user] as? [String: Any]
    let user = User(json: userJSON)
    let updated_at = json?[Keys.updated_at] as? String
    let html_url = json?[Keys.html_url] as? String
    let body = json?[Keys.body] as? String
    let closed_at = json?[Keys.closed_at] as? String
    let href = json?[Keys.href] as? String
    let locked = json?[Keys.locked] as? Bool
    let number = json?[Keys.number] as? NSNumber
    let milestoneJSON = json?[Keys.milestone] as? [String: Any]
    let milestone = Milestone(json: milestoneJSON)
    let labels_url = json?[Keys.labels_url] as? String
    let id = json?[Keys.id] as? NSNumber
    let pull_requestJSON = json?[Keys.pull_request] as? [String: Any]
    let pull_request = PullRequest(json: pull_requestJSON)
    let repositoryJSON = json?[Keys.repository] as? [String: Any]
    let repository = Repository(json: repositoryJSON)
    let created_at = json?[Keys.created_at] as? String
    let comments = json?[Keys.comments] as? NSNumber
    let title = json?[Keys.title] as? String
    let comments_url = json?[Keys.comments_url] as? String
    let assigneeJSON = json?[Keys.assignee] as? [String: Any]
    let assignee = User(json: assigneeJSON)
    let events_url = json?[Keys.events_url] as? String
    let url = json?[Keys.url] as? String
    let repository_url = json?[Keys.repository_url] as? String
    self.init(
      state: state,
      labels: labels,
      user: user,
      updated_at: updated_at,
      html_url: html_url,
      body: body,
      closed_at: closed_at,
      href: href,
      locked: locked,
      number: number,
      milestone: milestone,
      labels_url: labels_url,
      id: id,
      pull_request: pull_request,
      repository: repository,
      created_at: created_at,
      comments: comments,
      title: title,
      comments_url: comments_url,
      assignee: assignee,
      events_url: events_url,
      url: url,
      repository_url: repository_url
    )
  }
  init(
    state: String?,
    labels: [Label]?,
    user: User?,
    updated_at: String?,
    html_url: String?,
    body: String?,
    closed_at: String?,
    href: String?,
    locked: Bool?,
    number: NSNumber?,
    milestone: Milestone?,
    labels_url: String?,
    id: NSNumber?,
    pull_request: PullRequest?,
    repository: Repository?,
    created_at: String?,
    comments: NSNumber?,
    title: String?,
    comments_url: String?,
    assignee: User?,
    events_url: String?,
    url: String?,
    repository_url: String?
    ) {
    self.state = state
    self.labels = labels
    self.user = user
    self.updated_at = updated_at
    self.html_url = html_url
    self.body = body
    self.closed_at = closed_at
    self.href = href
    self.locked = locked
    self.number = number
    self.milestone = milestone
    self.labels_url = labels_url
    self.id = id
    self.pull_request = pull_request
    self.repository = repository
    self.created_at = created_at
    self.comments = comments
    self.title = title
    self.comments_url = comments_url
    self.assignee = assignee
    self.events_url = events_url
    self.url = url
    self.repository_url = repository_url
  }
  convenience init?(coder aDecoder: NSCoder) {
    let state = aDecoder.decodeObject(forKey: Keys.state) as? String
    let labels = aDecoder.decodeObject(forKey: Keys.labels) as? [Label]
    let user = aDecoder.decodeObject(forKey: Keys.user) as? User
    let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String
    let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String
    let body = aDecoder.decodeObject(forKey: Keys.body) as? String
    let closed_at = aDecoder.decodeObject(forKey: Keys.closed_at) as? String
    let href = aDecoder.decodeObject(forKey: Keys.href) as? String
    let locked = aDecoder.decodeBool(forKey: Keys.locked)
    let number = aDecoder.decodeObject(forKey: Keys.number) as? NSNumber
    let milestone = aDecoder.decodeObject(forKey: Keys.milestone) as? Milestone
    let labels_url = aDecoder.decodeObject(forKey: Keys.labels_url) as? String
    let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber
    let pull_request = aDecoder.decodeObject(forKey: Keys.pull_request) as? PullRequest
    let repository = aDecoder.decodeObject(forKey: Keys.repository) as? Repository
    let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String
    let comments = aDecoder.decodeObject(forKey: Keys.comments) as? NSNumber
    let title = aDecoder.decodeObject(forKey: Keys.title) as? String
    let comments_url = aDecoder.decodeObject(forKey: Keys.comments_url) as? String
    let assignee = aDecoder.decodeObject(forKey: Keys.assignee) as? User
    let events_url = aDecoder.decodeObject(forKey: Keys.events_url) as? String
    let url = aDecoder.decodeObject(forKey: Keys.url) as? String
    let repository_url = aDecoder.decodeObject(forKey: Keys.repository_url) as? String
    self.init(
      state: state,
      labels: labels,
      user: user,
      updated_at: updated_at,
      html_url: html_url,
      body: body,
      closed_at: closed_at,
      href: href,
      locked: locked,
      number: number,
      milestone: milestone,
      labels_url: labels_url,
      id: id,
      pull_request: pull_request,
      repository: repository,
      created_at: created_at,
      comments: comments,
      title: title,
      comments_url: comments_url,
      assignee: assignee,
      events_url: events_url,
      url: url,
      repository_url: repository_url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: Keys.state)
    aCoder.encode(labels, forKey: Keys.labels)
    aCoder.encode(user, forKey: Keys.user)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(body, forKey: Keys.body)
    aCoder.encode(closed_at, forKey: Keys.closed_at)
    aCoder.encode(href, forKey: Keys.href)
    aCoder.encode(locked, forKey: Keys.locked)
    aCoder.encode(number, forKey: Keys.number)
    aCoder.encode(milestone, forKey: Keys.milestone)
    aCoder.encode(labels_url, forKey: Keys.labels_url)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(pull_request, forKey: Keys.pull_request)
    aCoder.encode(repository, forKey: Keys.repository)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(comments, forKey: Keys.comments)
    aCoder.encode(title, forKey: Keys.title)
    aCoder.encode(comments_url, forKey: Keys.comments_url)
    aCoder.encode(assignee, forKey: Keys.assignee)
    aCoder.encode(events_url, forKey: Keys.events_url)
    aCoder.encode(url, forKey: Keys.url)
    aCoder.encode(repository_url, forKey: Keys.repository_url)
  }
}