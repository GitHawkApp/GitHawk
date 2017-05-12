import Foundation
final class Reaction: NSObject, NSCoding {
  struct Keys {
    static let laugh = "laugh"
    static let hooray = "hooray"
    static let total_count = "total_count"
    static let heart = "heart"
    static let plus1 = "+1"
    static let minus1 = "-1"
    static let confused = "confused"
    static let url = "url"
  }
  let laugh: NSNumber
  let hooray: NSNumber
  let total_count: NSNumber
  let heart: NSNumber
  let plus1: NSNumber
  let minus1: NSNumber
  let confused: NSNumber
  let url: String
  convenience init?(json: [String: Any]?) {
    guard let laugh = json?[Keys.laugh] as? NSNumber else { return nil }
    guard let hooray = json?[Keys.hooray] as? NSNumber else { return nil }
    guard let total_count = json?[Keys.total_count] as? NSNumber else { return nil }
    guard let heart = json?[Keys.heart] as? NSNumber else { return nil }
    guard let plus1 = json?[Keys.plus1] as? NSNumber else { return nil }
    guard let minus1 = json?[Keys.minus1] as? NSNumber else { return nil }
    guard let confused = json?[Keys.confused] as? NSNumber else { return nil }
    guard let url = json?[Keys.url] as? String else { return nil }
    self.init(
      laugh: laugh,
      hooray: hooray,
      total_count: total_count,
      heart: heart,
      plus1: plus1,
      minus1: minus1,
      confused: confused,
      url: url
    )
  }
  init(
    laugh: NSNumber,
    hooray: NSNumber,
    total_count: NSNumber,
    heart: NSNumber,
    plus1: NSNumber,
    minus1: NSNumber,
    confused: NSNumber,
    url: String
    ) {
    self.laugh = laugh
    self.hooray = hooray
    self.total_count = total_count
    self.heart = heart
    self.plus1 = plus1
    self.minus1 = minus1
    self.confused = confused
    self.url = url
  }
  convenience init?(coder aDecoder: NSCoder) {
    guard let laugh = aDecoder.decodeObject(forKey: Keys.laugh) as? NSNumber else { return nil }
    guard let hooray = aDecoder.decodeObject(forKey: Keys.hooray) as? NSNumber else { return nil }
    guard let total_count = aDecoder.decodeObject(forKey: Keys.total_count) as? NSNumber else { return nil }
    guard let heart = aDecoder.decodeObject(forKey: Keys.heart) as? NSNumber else { return nil }
    guard let plus1 = aDecoder.decodeObject(forKey: Keys.plus1) as? NSNumber else { return nil }
    guard let minus1 = aDecoder.decodeObject(forKey: Keys.minus1) as? NSNumber else { return nil }
    guard let confused = aDecoder.decodeObject(forKey: Keys.confused) as? NSNumber else { return nil }
    guard let url = aDecoder.decodeObject(forKey: Keys.url) as? String else { return nil }
    self.init(
      laugh: laugh,
      hooray: hooray,
      total_count: total_count,
      heart: heart,
      plus1: plus1,
      minus1: minus1,
      confused: confused,
      url: url
    )
  }
  func encode(with aCoder: NSCoder) {
    aCoder.encode(laugh, forKey: Keys.laugh)
    aCoder.encode(hooray, forKey: Keys.hooray)
    aCoder.encode(total_count, forKey: Keys.total_count)
    aCoder.encode(heart, forKey: Keys.heart)
    aCoder.encode(plus1, forKey: Keys.plus1)
    aCoder.encode(minus1, forKey: Keys.minus1)
    aCoder.encode(confused, forKey: Keys.confused)
    aCoder.encode(url, forKey: Keys.url)
  }
}