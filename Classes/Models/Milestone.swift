import Foundation
final class Milestone: NSObject, NSCoding {
  struct Keys {
    static let state = "state"
    static let updated_at = "updated_at"
    static let open_issues = "open_issues"
    static let html_url = "html_url"
    static let closed_at = "closed_at"
    static let description_ = "description"
    static let number = "number"
    static let creator = "creator"
    static let labels_url = "labels_url"
    static let id = "id"
    static let closed_issues = "closed_issues"
    static let created_at = "created_at"
    static let title = "title"
    static let due_on = "due_on"
    static let url = "url"
  }
  let state: String
  let updated_at: String
  let open_issues: NSNumber
  let html_url: String
  let closed_at: String
  let description_: String
  let number: NSNumber
  let creator: User
  let labels_url: String
  let id: NSNumber
  let closed_issues: NSNumber
  let created_at: String
  let title: String
  let due_on: String
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let state = json?[Keys.state] as? String else { return nil }
    guard let updated_at = json?[Keys.updated_at] as? String else { return nil }
    guard let open_issues = json?[Keys.open_issues] as? NSNumber else { return nil }
    guard let html_url = json?[Keys.html_url] as? String else { return nil }
    guard let closed_at = json?[Keys.closed_at] as? String else { return nil }
    guard let description_ = json?[Keys.description_] as? String else { return nil }
    guard let number = json?[Keys.number] as? NSNumber else { return nil }
    guard let creatorJSON = json?[Keys.creator] as? [String: Any] else { return nil }
    guard let creator = User(json: creatorJSON) else { return nil }
    guard let labels_url = json?[Keys.labels_url] as? String else { return nil }
    guard let id = json?[Keys.id] as? NSNumber else { return nil }
    guard let closed_issues = json?[Keys.closed_issues] as? NSNumber else { return nil }
    guard let created_at = json?[Keys.created_at] as? String else { return nil }
    guard let title = json?[Keys.title] as? String else { return nil }
    guard let due_on = json?[Keys.due_on] as? String else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      state: state,
      updated_at: updated_at,
      open_issues: open_issues,
      html_url: html_url,
      closed_at: closed_at,
      description_: description_,
      number: number,
      creator: creator,
      labels_url: labels_url,
      id: id,
      closed_issues: closed_issues,
      created_at: created_at,
      title: title,
      due_on: due_on,
      url: url
    )
  }
  init(
    state: String,
    updated_at: String,
    open_issues: NSNumber,
    html_url: String,
    closed_at: String,
    description_: String,
    number: NSNumber,
    creator: User,
    labels_url: String,
    id: NSNumber,
    closed_issues: NSNumber,
    created_at: String,
    title: String,
    due_on: String,
    url: String
    ) {
    self.state = state
    self.updated_at = updated_at
    self.open_issues = open_issues
    self.html_url = html_url
    self.closed_at = closed_at
    self.description_ = description_
    self.number = number
    self.creator = creator
    self.labels_url = labels_url
    self.id = id
    self.closed_issues = closed_issues
    self.created_at = created_at
    self.title = title
    self.due_on = due_on
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let state = aDecoder.decodeObject(forKey: Keys.state) as? String else { return nil }
    guard let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String else { return nil }
    guard let open_issues = aDecoder.decodeObject(forKey: Keys.open_issues) as? NSNumber else { return nil }
    guard let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String else { return nil }
    guard let closed_at = aDecoder.decodeObject(forKey: Keys.closed_at) as? String else { return nil }
    guard let description_ = aDecoder.decodeObject(forKey: Keys.description_) as? String else { return nil }
    guard let number = aDecoder.decodeObject(forKey: Keys.number) as? NSNumber else { return nil }
    guard let creator = aDecoder.decodeObject(forKey: Keys.creator) as? User else { return nil }
    guard let labels_url = aDecoder.decodeObject(forKey: Keys.labels_url) as? String else { return nil }
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber else { return nil }
    guard let closed_issues = aDecoder.decodeObject(forKey: Keys.closed_issues) as? NSNumber else { return nil }
    guard let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String else { return nil }
    guard let title = aDecoder.decodeObject(forKey: Keys.title) as? String else { return nil }
    guard let due_on = aDecoder.decodeObject(forKey: Keys.due_on) as? String else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      state: state,
      updated_at: updated_at,
      open_issues: open_issues,
      html_url: html_url,
      closed_at: closed_at,
      description_: description_,
      number: number,
      creator: creator,
      labels_url: labels_url,
      id: id,
      closed_issues: closed_issues,
      created_at: created_at,
      title: title,
      due_on: due_on,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: Keys.state)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(open_issues, forKey: Keys.open_issues)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(closed_at, forKey: Keys.closed_at)
    aCoder.encode(description_, forKey: Keys.description_)
    aCoder.encode(number, forKey: Keys.number)
    aCoder.encode(creator, forKey: Keys.creator)
    aCoder.encode(labels_url, forKey: Keys.labels_url)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(closed_issues, forKey: Keys.closed_issues)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(title, forKey: Keys.title)
    aCoder.encode(due_on, forKey: Keys.due_on)
    aCoder.encode(url, forKey: Keys.url)
  }
}