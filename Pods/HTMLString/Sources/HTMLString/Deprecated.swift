import Foundation

/// Function to call when a function is unavailable.
fileprivate func unavailable(_ fn: String = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError("[HTMLString] \(fn) is not available.", file: file, line: line)
}

// MARK: String

extension String {

    @available(*, unavailable, deprecated: 3.0, renamed: "addingUnicodeEntities")
    public var escapingForUnicodeHTML: String {
        unavailable()
    }

    @available(*, unavailable, deprecated: 3.0, renamed: "addingASCIIEntities")
    public var escapingForASCIIHTML: String {
        unavailable()
    }

    @available(*, unavailable, deprecated: 3.0, renamed: "removingHTMLEntities")
    public var unescapingFromHTML: String {
        unavailable()
    }

}

// MARK: NSString

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

extension NSString {

    @nonobjc
    @available(*, unavailable, deprecated: 3.0, renamed: "addingUnicodeEntities")
    public func stringByEscapingForUnicodeHTML() -> NSString {
        unavailable()
    }

    @nonobjc
    @available(*, unavailable, deprecated: 3.0, renamed: "addingASCIIEntities")
    public func stringByEscapingForASCIIHTML() -> NSString {
        unavailable()
    }

    @nonobjc
    @available(*, unavailable, deprecated: 3.0, renamed: "removingHTMLEntities")
    public func stringByUnescapingFromHTML() -> NSString {
        unavailable()
    }

}

#endif
