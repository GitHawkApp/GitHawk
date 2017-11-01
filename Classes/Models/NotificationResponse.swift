import Foundation
final class NotificationResponse: NSObject, NSCoding {
  enum Keys {
    static let reason = "reason"
    static let updated_at = "updated_at"
    static let unread = "unread"
    static let id = "id"
    static let repository = "repository"
    static let last_read_at = "last_read_at"
    static let url = "url"
    static let subject = "subject"
  }
  let reason: String
  let updated_at: String
  let unread: Bool
  let id: String
  let repository: Repository
  let last_read_at: String?
  let url: String
  let subject: Subject
  convenience init?(json: [String: Any]?) {
    guard let reason = json?[Keys.reason] as? String else { return nil }
    guard let updated_at = json?[Keys.updated_at] as? String else { return nil }
    guard let unread = json?[Keys.unread] as? Bool else { return nil }
    guard let id = json?[Keys.id] as? String else { return nil }
    guard let repositoryJSON = json?[Keys.repository] as? [String: Any] else { return nil }
    guard let repository = Repository(json: repositoryJSON) else { return nil }
    let last_read_at = json?[Keys.last_read_at] as? String
    guard let url = json?[Keys.url] as? String else { return nil }
    guard let subjectJSON = json?[Keys.subject] as? [String: Any] else { return nil }
    guard let subject = Subject(json: subjectJSON) else { return nil }
    self.init(
      reason: reason,
      updated_at: updated_at,
      unread: unread,
      id: id,
      repository: repository,
      last_read_at: last_read_at,
      url: url,
      subject: subject
    )
  }
  init(
    reason: String,
    updated_at: String,
    unread: Bool,
    id: String,
    repository: Repository,
    last_read_at: String?,
    url: String,
    subject: Subject
    ) {
    self.reason = reason
    self.updated_at = updated_at
    self.unread = unread
    self.id = id
    self.repository = repository
    self.last_read_at = last_read_at
    self.url = url
    self.subject = subject
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let reason = aDecoder.decodeObject(forKey: Keys.reason) as? String else { return nil }
    guard let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String else { return nil }
    let unread = aDecoder.decodeBool(forKey: Keys.unread)
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? String else { return nil }
    guard let repository = aDecoder.decodeObject(forKey: Keys.repository) as? Repository else { return nil }
    let last_read_at = aDecoder.decodeObject(forKey: Keys.last_read_at) as? String
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    guard let subject = aDecoder.decodeObject(forKey: Keys.subject) as? Subject else { return nil }
    self.init(
      reason: reason,
      updated_at: updated_at,
      unread: unread,
      id: id,
      repository: repository,
      last_read_at: last_read_at,
      url: url,
      subject: subject
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(reason, forKey: Keys.reason)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(unread, forKey: Keys.unread)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(repository, forKey: Keys.repository)
    aCoder.encode(last_read_at, forKey: Keys.last_read_at)
    aCoder.encode(url, forKey: Keys.url)
    aCoder.encode(subject, forKey: Keys.subject)
  }
}
