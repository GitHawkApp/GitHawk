import Foundation
final class File: NSObject, NSCoding {
  struct Keys {
    static let status = "status"
    static let changes = "changes"
    static let filename = "filename"
    static let additions = "additions"
    static let raw_url = "raw_url"
    static let deletions = "deletions"
    static let sha = "sha"
    static let blob_url = "blob_url"
    static let patch = "patch"
    static let contents_url = "contents_url"
  }
  let status: String
  let changes: NSNumber
  let filename: String
  let additions: NSNumber
  let raw_url: String
  let deletions: NSNumber
  let sha: String
  let blob_url: String
  let patch: String
  let contents_url: String
  convenience init?(json: [String: Any]?) {
    guard let status = json?[Keys.status] as? String else { return nil }
    guard let changes = json?[Keys.changes] as? NSNumber else { return nil }
    guard let filename = json?[Keys.filename] as? String else { return nil }
    guard let additions = json?[Keys.additions] as? NSNumber else { return nil }
    guard let raw_url = json?[Keys.raw_url] as? String else { return nil }
    guard let deletions = json?[Keys.deletions] as? NSNumber else { return nil }
    guard let sha = json?[Keys.sha] as? String else { return nil }
    guard let blob_url = json?[Keys.blob_url] as? String else { return nil }
    guard let patch = json?[Keys.patch] as? String else { return nil }
    guard let contents_url = json?[Keys.contents_url] as? String else { return nil }
    self.init(
      status: status,
      changes: changes,
      filename: filename,
      additions: additions,
      raw_url: raw_url,
      deletions: deletions,
      sha: sha,
      blob_url: blob_url,
      patch: patch,
      contents_url: contents_url
    )
  }
  init(
    status: String,
    changes: NSNumber,
    filename: String,
    additions: NSNumber,
    raw_url: String,
    deletions: NSNumber,
    sha: String,
    blob_url: String,
    patch: String,
    contents_url: String
    ) {
    self.status = status
    self.changes = changes
    self.filename = filename
    self.additions = additions
    self.raw_url = raw_url
    self.deletions = deletions
    self.sha = sha
    self.blob_url = blob_url
    self.patch = patch
    self.contents_url = contents_url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let status = aDecoder.decodeObject(forKey: Keys.status) as? String else { return nil }
    guard let changes = aDecoder.decodeObject(forKey: Keys.changes) as? NSNumber else { return nil }
    guard let filename = aDecoder.decodeObject(forKey: Keys.filename) as? String else { return nil }
    guard let additions = aDecoder.decodeObject(forKey: Keys.additions) as? NSNumber else { return nil }
    guard let raw_url = aDecoder.decodeObject(forKey: Keys.raw_url) as? String else { return nil }
    guard let deletions = aDecoder.decodeObject(forKey: Keys.deletions) as? NSNumber else { return nil }
    guard let sha = aDecoder.decodeObject(forKey: Keys.sha) as? String else { return nil }
    guard let blob_url = aDecoder.decodeObject(forKey: Keys.blob_url) as? String else { return nil }
    guard let patch = aDecoder.decodeObject(forKey: Keys.patch) as? String else { return nil }
    guard let contents_url = aDecoder.decodeObject(forKey: Keys.contents_url) as? String else { return nil }
    self.init(
      status: status,
      changes: changes,
      filename: filename,
      additions: additions,
      raw_url: raw_url,
      deletions: deletions,
      sha: sha,
      blob_url: blob_url,
      patch: patch,
      contents_url: contents_url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: Keys.status)
    aCoder.encode(changes, forKey: Keys.changes)
    aCoder.encode(filename, forKey: Keys.filename)
    aCoder.encode(additions, forKey: Keys.additions)
    aCoder.encode(raw_url, forKey: Keys.raw_url)
    aCoder.encode(deletions, forKey: Keys.deletions)
    aCoder.encode(sha, forKey: Keys.sha)
    aCoder.encode(blob_url, forKey: Keys.blob_url)
    aCoder.encode(patch, forKey: Keys.patch)
    aCoder.encode(contents_url, forKey: Keys.contents_url)
  }
}
