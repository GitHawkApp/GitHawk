import Foundation
final class Content: NSObject, NSCoding {
  struct Keys {
    static let content = "content"
    static let name = "name"
    static let path = "path"
    static let download_url = "download_url"
    static let encoding = "encoding"
    static let html_url = "html_url"
    static let _links = "_links"
    static let git_url = "git_url"
    static let size = "size"
    static let sha = "sha"
    static let type = "type"
    static let url = "url"
  }
  let content: String
  let name: String
  let path: String
  let download_url: String
  let encoding: String
  let html_url: String
  let _links: Link
  let git_url: String
  let size: NSNumber
  let sha: String
  let type: String
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let content = json?[Keys.content] as? String else { return nil }
    guard let name = json?[Keys.name] as? String else { return nil }
    guard let path = json?[Keys.path] as? String else { return nil }
    guard let download_url = json?[Keys.download_url] as? String else { return nil }
    guard let encoding = json?[Keys.encoding] as? String else { return nil }
    guard let html_url = json?[Keys.html_url] as? String else { return nil }
    guard let _linksJSON = json?[Keys._links] as? [String: Any] else { return nil }
    guard let _links = Link(json: _linksJSON) else { return nil }
    guard let git_url = json?[Keys.git_url] as? String else { return nil }
    guard let size = json?[Keys.size] as? NSNumber else { return nil }
    guard let sha = json?[Keys.sha] as? String else { return nil }
    guard let type = json?[Keys.type] as? String else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      content: content,
      name: name,
      path: path,
      download_url: download_url,
      encoding: encoding,
      html_url: html_url,
      _links: _links,
      git_url: git_url,
      size: size,
      sha: sha,
      type: type,
      url: url
    )
  }
  init(
    content: String,
    name: String,
    path: String,
    download_url: String,
    encoding: String,
    html_url: String,
    _links: Link,
    git_url: String,
    size: NSNumber,
    sha: String,
    type: String,
    url: String
    ) {
    self.content = content
    self.name = name
    self.path = path
    self.download_url = download_url
    self.encoding = encoding
    self.html_url = html_url
    self._links = _links
    self.git_url = git_url
    self.size = size
    self.sha = sha
    self.type = type
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let content = aDecoder.decodeObject(forKey: Keys.content) as? String else { return nil }
    guard let name = aDecoder.decodeObject(forKey: Keys.name) as? String else { return nil }
    guard let path = aDecoder.decodeObject(forKey: Keys.path) as? String else { return nil }
    guard let download_url = aDecoder.decodeObject(forKey: Keys.download_url) as? String else { return nil }
    guard let encoding = aDecoder.decodeObject(forKey: Keys.encoding) as? String else { return nil }
    guard let html_url = aDecoder.decodeObject(forKey: Keys.html_url) as? String else { return nil }
    guard let _links = aDecoder.decodeObject(forKey: Keys._links) as? Link else { return nil }
    guard let git_url = aDecoder.decodeObject(forKey: Keys.git_url) as? String else { return nil }
    guard let size = aDecoder.decodeObject(forKey: Keys.size) as? NSNumber else { return nil }
    guard let sha = aDecoder.decodeObject(forKey: Keys.sha) as? String else { return nil }
    guard let type = aDecoder.decodeObject(forKey: Keys.type) as? String else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      content: content,
      name: name,
      path: path,
      download_url: download_url,
      encoding: encoding,
      html_url: html_url,
      _links: _links,
      git_url: git_url,
      size: size,
      sha: sha,
      type: type,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(content, forKey: Keys.content)
    aCoder.encode(name, forKey: Keys.name)
    aCoder.encode(path, forKey: Keys.path)
    aCoder.encode(download_url, forKey: Keys.download_url)
    aCoder.encode(encoding, forKey: Keys.encoding)
    aCoder.encode(html_url, forKey: Keys.html_url)
    aCoder.encode(_links, forKey: Keys._links)
    aCoder.encode(git_url, forKey: Keys.git_url)
    aCoder.encode(size, forKey: Keys.size)
    aCoder.encode(sha, forKey: Keys.sha)
    aCoder.encode(type, forKey: Keys.type)
    aCoder.encode(url, forKey: Keys.url)
  }
}
