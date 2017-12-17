public protocol Matcher: Nameable {
  func toMatchSnapshot()
}

public protocol Nameable {
  func toMatchSnapshot(named: String?)
}
