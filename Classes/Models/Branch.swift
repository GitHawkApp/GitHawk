import Foundation
final class Branch: NSObject, NSCoding {
  struct Keys {
    static let label = "label"
    static let user = "user"
    static let repo = "repo"
    static let ref = "ref"
    static let sha = "sha"
  }
  let label: String
  let user: User
  let repo: Repository
  let ref: String
  let sha: String
  convenience init?(json: [String: Any]?) {
    guard let label = json?[Keys.label] as? String else { return nil }
    guard let userJSON = json?[Keys.user] as? [String: Any] else { return nil }
    guard let user = User(json: userJSON) else { return nil }
    guard let repoJSON = json?[Keys.repo] as? [String: Any] else { return nil }
    guard let repo = Repository(json: repoJSON) else { return nil }
    guard let ref = json?[Keys.ref] as? String else { return nil }
    guard let sha = json?[Keys.sha] as? String else { return nil }
    self.init(
      label: label,
      user: user,
      repo: repo,
      ref: ref,
      sha: sha
    )
  }
  init(
    label: String,
    user: User,
    repo: Repository,
    ref: String,
    sha: String
    ) {
    self.label = label
    self.user = user
    self.repo = repo
    self.ref = ref
    self.sha = sha
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let label = aDecoder.decodeObject(forKey: Keys.label) as? String else { return nil }
    guard let user = aDecoder.decodeObject(forKey: Keys.user) as? User else { return nil }
    guard let repo = aDecoder.decodeObject(forKey: Keys.repo) as? Repository else { return nil }
    guard let ref = aDecoder.decodeObject(forKey: Keys.ref) as? String else { return nil }
    guard let sha = aDecoder.decodeObject(forKey: Keys.sha) as? String else { return nil }
    self.init(
      label: label,
      user: user,
      repo: repo,
      ref: ref,
      sha: sha
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(label, forKey: Keys.label)
    aCoder.encode(user, forKey: Keys.user)
    aCoder.encode(repo, forKey: Keys.repo)
    aCoder.encode(ref, forKey: Keys.ref)
    aCoder.encode(sha, forKey: Keys.sha)
  }
}