import Foundation

final class Authorization: NSObject, NSCoding {
  struct Keys {
    static let note = "note"
    static let updated_at = "updated_at"
    static let id = "id"
    static let app = "app"
    static let token = "token"
    static let scopes = "scopes"
    static let created_at = "created_at"
    static let fingerprint = "fingerprint"
    static let hashed_token = "hashed_token"
    static let token_last_eight = "token_last_eight"
    static let note_url = "note_url"
    static let url = "url"
  }
  let note: String
  let updated_at: String
  let id: NSNumber
  let app: App
  let token: String
  let scopes: [String]
  let created_at: String
  let fingerprint: String?
  let hashed_token: String
  let token_last_eight: String
  let note_url: String?
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let note = json?[Keys.note] as? String else { return nil }
    guard let updated_at = json?[Keys.updated_at] as? String else { return nil }
    guard let id = json?[Keys.id] as? NSNumber else { return nil }
    guard let appJSON = json?[Keys.app] as? [String: Any] else { return nil }
    guard let app = App(json: appJSON) else { return nil }
    guard let token = json?[Keys.token] as? String else { return nil }
    guard let scopes = json?[Keys.scopes] as? [String] else { return nil }
    guard let created_at = json?[Keys.created_at] as? String else { return nil }
    let fingerprint = json?[Keys.fingerprint] as? String
    guard let hashed_token = json?[Keys.hashed_token] as? String else { return nil }
    guard let token_last_eight = json?[Keys.token_last_eight] as? String else { return nil }
    let note_url = json?[Keys.note_url] as? String
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      note: note,
      updated_at: updated_at,
      id: id,
      app: app,
      token: token,
      scopes: scopes,
      created_at: created_at,
      fingerprint: fingerprint,
      hashed_token: hashed_token,
      token_last_eight: token_last_eight,
      note_url: note_url,
      url: url
    )
  }
  init(
    note: String,
    updated_at: String,
    id: NSNumber,
    app: App,
    token: String,
    scopes: [String],
    created_at: String,
    fingerprint: String?,
    hashed_token: String,
    token_last_eight: String,
    note_url: String?,
    url: String
    ) {
    self.note = note
    self.updated_at = updated_at
    self.id = id
    self.app = app
    self.token = token
    self.scopes = scopes
    self.created_at = created_at
    self.fingerprint = fingerprint
    self.hashed_token = hashed_token
    self.token_last_eight = token_last_eight
    self.note_url = note_url
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let note = aDecoder.decodeObject(forKey: Keys.note) as? String else { return nil }
    guard let updated_at = aDecoder.decodeObject(forKey: Keys.updated_at) as? String else { return nil }
    guard let id = aDecoder.decodeObject(forKey: Keys.id) as? NSNumber else { return nil }
    guard let app = aDecoder.decodeObject(forKey: Keys.app) as? App else { return nil }
    guard let token = aDecoder.decodeObject(forKey: Keys.token) as? String else { return nil }
    guard let scopes = aDecoder.decodeObject(forKey: Keys.scopes) as? [String] else { return nil }
    guard let created_at = aDecoder.decodeObject(forKey: Keys.created_at) as? String else { return nil }
    let fingerprint = aDecoder.decodeObject(forKey: Keys.fingerprint) as? String
    guard let hashed_token = aDecoder.decodeObject(forKey: Keys.hashed_token) as? String else { return nil }
    guard let token_last_eight = aDecoder.decodeObject(forKey: Keys.token_last_eight) as? String else { return nil }
    let note_url = aDecoder.decodeObject(forKey: Keys.note_url) as? String
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      note: note,
      updated_at: updated_at,
      id: id,
      app: app,
      token: token,
      scopes: scopes,
      created_at: created_at,
      fingerprint: fingerprint,
      hashed_token: hashed_token,
      token_last_eight: token_last_eight,
      note_url: note_url,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(note, forKey: Keys.note)
    aCoder.encode(updated_at, forKey: Keys.updated_at)
    aCoder.encode(id, forKey: Keys.id)
    aCoder.encode(app, forKey: Keys.app)
    aCoder.encode(token, forKey: Keys.token)
    aCoder.encode(scopes, forKey: Keys.scopes)
    aCoder.encode(created_at, forKey: Keys.created_at)
    aCoder.encode(fingerprint, forKey: Keys.fingerprint)
    aCoder.encode(hashed_token, forKey: Keys.hashed_token)
    aCoder.encode(token_last_eight, forKey: Keys.token_last_eight)
    aCoder.encode(note_url, forKey: Keys.note_url)
    aCoder.encode(url, forKey: Keys.url)
  }
}
