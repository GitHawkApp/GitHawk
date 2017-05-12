import Foundation
final class Event: NSObject, NSCoding {
  struct Keys {
    static let commit_url = "commit_url"
    static let commit_id = "commit_id"
    static let id = "id"
    static let created_at = "created_at"
    static let event = "event"
    static let actor = "actor"
    static let url = "url"
  }
  let commit_url: String
  let commit_id: String
  let id: NSNumber
  let created_at: String
  let event: String
  let actor: User
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let commit_url = json?[Keys.commit_url] as? String else { return nil }
    guard let commit_id = json?[Keys.commit_id] as? String else { return nil }
    guard let id = json?[Keys.id] as? NSNumber else { return nil }
    guard let created_at = json?[Keys.created_at] as? String else { return nil }
    guard let event = json?[Keys.event] as? String else { return nil }
    guard let actorJSON = json?[Keys.actor] as? [String: Any] else { return nil }
    guard let actor = User(json: actorJSON) else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      commit_url: commit_url,
      commit_id: commit_id,
      id: id,
      created_at: created_at,
      event: event,
      actor: actor,
      url: url
    )
  }
  init(
    commit_url: String,
    commit_id: String,
    id: NSNumber,
    created_at: String,
    event: String,
    actor: User,
    url: String
    ) {
    self.commit_url = commit_url
    self.commit_id = commit_id
    self.id = id
    self.created_at = created_at
    self.event = event
    self.actor = actor
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let commit_url = aDecoder.decodeObject(forKey: Keys.commit_url) as? String else { return nil }
    guard let commit_id = aDecoder.decodeObject(forKey: Keys.commit_id) as? String else { return nil }
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber else { return nil }
    guard let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String else { return nil }
    guard let event = aDecoder.decodeObject(forKey: Keys.event) as? String else { return nil }
    guard let actor = aDecoder.decodeObject(forKey: Keys.actor) as? User else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      commit_url: commit_url,
      commit_id: commit_id,
      id: id,
      created_at: created_at,
      event: event,
      actor: actor,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(commit_url, forKey: Keys.commit_url)
    aCoder.encode(commit_id, forKey: Keys.commit_id)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(event, forKey: Keys.event)
    aCoder.encode(actor, forKey: Keys.actor)
    aCoder.encode(url, forKey: Keys.url)
  }
}