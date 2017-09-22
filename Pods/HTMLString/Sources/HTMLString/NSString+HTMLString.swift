import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

extension NSString {

    ///
    /// Returns a new string made from the `String` by replacing every character
    /// incompatible with HTML Unicode encoding (UTF-16 or UTF-8) by a decimal
    /// HTML entity.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&` | `&#38;` | Decimal entity (part of the Unicode special characters) |
    /// | `Σ` | `Σ` | Not escaped (Unicode compliant) |
    /// | `🇺🇸` | `🇺🇸` | Not escaped (Unicode compliant) |
    /// | `a` | `a` | Not escaped (alphanumerical) |
    ///
    /// **Complexity**: `O(N)` where `N` is the number of characters in the string.
    ///

    @objc(stringByAddingUnicodeEntities)
    public func addingUnicodeEntities() -> NSString {
        return (self as String).addingUnicodeEntities as NSString
    }

    ///
    /// Returns a new string made from the `String` by replacing every character
    /// incompatible with HTML ASCII encoding by a decimal HTML entity.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&` | `&#38;` | Decimal entity |
    /// | `Σ` | `&#931;` | Decimal entity |
    /// | `🇺🇸` | `&#127482;&#127480;` | Combined decimal entities (extented grapheme cluster) |
    /// | `a` | `a` | Not escaped (alphanumerical) |
    ///
    /// ### Performance
    ///
    /// If your webpage is unicode encoded (UTF-16 or UTF-8) use `escapingForUnicodeHTML` instead
    /// as it is faster, and produces less bloated and more readable HTML (as long as you are using
    /// a unicode compliant HTML reader).
    ///
    /// **Complexity**: `O(N)` where `N` is the number of characters in the string.
    ///

    @objc(stringByAddingASCIIEntities)
    public func addingASCIIEntities() -> NSString {
        return (self as String).addingASCIIEntities as NSString
    }

    ///
    /// Returns a new string made from the `String` by replacing every HTML entity
    /// with the matching Unicode character.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&amp;` | `&` | Keyword entity |
    /// | `&#931;` | `Σ` | Decimal entity |
    /// | `&#x10d;` | `č` | Hexadecimal entity |
    /// | `&#127482;&#127480;` | `🇺🇸` | Combined decimal entities (extented grapheme cluster) |
    /// | `a` | `a` | Not an entity |
    /// | `&` | `&` | Not an entity |
    ///
    /// **Complexity**: `O(N)` where `N` is the number of characters in the string.
    ///

    @objc(stringByRemovingHTMLEntities)
    public func removingHTMLEntities() -> NSString {
        return (self as String).removingHTMLEntities as NSString
    }

}

#endif
