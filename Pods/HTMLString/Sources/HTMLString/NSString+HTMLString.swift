import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

extension NSString {

    ///
    /// Returns a copy of the current `String` where every character incompatible with HTML Unicode
    /// encoding (UTF-16 or UTF-8) is replaced by a decimal HTML entity.
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

    @objc(stringByAddingUnicodeEntities)
    public func addingUnicodeEntities() -> NSString {
        return (self as String).addingUnicodeEntities as NSString
    }

    ///
    /// Returns a copy of the current `String` where every character incompatible with HTML ASCII
    /// encoding is replaced by a decimal HTML entity.
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
    /// If your webpage is unicode encoded (UTF-16 or UTF-8) use `addingUnicodeEntities` instead,
    /// as it is faster and produces a less bloated and more readable HTML.
    ///

    @objc(stringByAddingASCIIEntities)
    public func addingASCIIEntities() -> NSString {
        return (self as String).addingASCIIEntities as NSString
    }

    ///
    /// Returns a copy of the current `String` where every HTML entity is replaced with the matching
    /// Unicode character.
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

    @objc(stringByRemovingHTMLEntities)
    public func removingHTMLEntities() -> NSString {
        return (self as String).removingHTMLEntities as NSString
    }

}

#endif
