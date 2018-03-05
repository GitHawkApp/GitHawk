import Foundation
final class File: NSObject, NSCoding {
  struct Keys {
    static let status = "status"
    static let changes = "changes"
    static let filename = "filename"
    static let additions = "additions"
    static let deletions = "deletions"
    static let sha = "sha"
    static let patch = "patch"
  }
  let status: String
  let changes: NSNumber
  let filename: String
  let additions: NSNumber
  let deletions: NSNumber
  let sha: String
  let patch: String
  convenience init?(json: [String: Any]?) {
    guard let status = json?[Keys.status] as? String else { return nil }
    guard let changes = json?[Keys.changes] as? NSNumber else { return nil }
    guard let filename = json?[Keys.filename] as? String else { return nil }
    guard let additions = json?[Keys.additions] as? NSNumber else { return nil }
    guard let deletions = json?[Keys.deletions] as? NSNumber else { return nil }
    guard let sha = json?[Keys.sha] as? String else { return nil }
    guard let patch = json?[Keys.patch] as? String else { return nil }
    self.init(
      status: status,
      changes: changes,
      filename: filename,
      additions: additions,
      deletions: deletions,
      sha: sha,
      patch: patch
    )
  }
  init(
    status: String,
    changes: NSNumber,
    filename: String,
    additions: NSNumber,
    deletions: NSNumber,
    sha: String,
    patch: String
    ) {
    self.status = status
    self.changes = changes
    self.filename = filename
    self.additions = additions
    self.deletions = deletions
    self.sha = sha
    self.patch = patch
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let status = aDecoder.decodeObject(forKey: Keys.status) as? String else { return nil }
    guard let changes = aDecoder.decodeObject(forKey: Keys.changes) as? NSNumber else { return nil }
    guard let filename = aDecoder.decodeObject(forKey: Keys.filename) as? String else { return nil }
    guard let additions = aDecoder.decodeObject(forKey: Keys.additions) as? NSNumber else { return nil }
    guard let deletions = aDecoder.decodeObject(forKey: Keys.deletions) as? NSNumber else { return nil }
    guard let sha = aDecoder.decodeObject(forKey: Keys.sha) as? String else { return nil }
    guard let patch = aDecoder.decodeObject(forKey: Keys.patch) as? String else { return nil }
    self.init(
      status: status,
      changes: changes,
      filename: filename,
      additions: additions,
      deletions: deletions,
      sha: sha,
      patch: patch
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: Keys.status)
    aCoder.encode(changes, forKey: Keys.changes)
    aCoder.encode(filename, forKey: Keys.filename)
    aCoder.encode(additions, forKey: Keys.additions)
    aCoder.encode(deletions, forKey: Keys.deletions)
    aCoder.encode(sha, forKey: Keys.sha)
    aCoder.encode(patch, forKey: Keys.patch)
  }
}
