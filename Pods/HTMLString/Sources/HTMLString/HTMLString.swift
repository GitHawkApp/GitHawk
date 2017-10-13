import Foundation

// MARK: Escaping

public extension String {

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

    public var addingUnicodeEntities: String {
        return unicodeScalars.reduce("") { $0 + $1.escapingIfNeeded }
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

    public var addingASCIIEntities: String {
        return unicodeScalars.reduce("") { $0 + $1.escapingForASCII }
    }

}

// MARK: - Unescaping

extension String {

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

    public var removingHTMLEntities: String {

        guard self.contains("&") else {
            return self
        }

        var result = String()
        var cursorPosition = startIndex

        while let delimiterRange = range(of: "&", range: cursorPosition ..< endIndex) {

            // Avoid unnecessary operations
            let head = self[cursorPosition ..< delimiterRange.lowerBound]
            result += head

            guard let semicolonRange = range(of: ";", range: delimiterRange.upperBound ..< endIndex) else {
                result += "&"
                cursorPosition = delimiterRange.upperBound
                break
            }

            let escapableContent = self[delimiterRange.upperBound ..< semicolonRange.lowerBound]
            let escapableContentString = String(escapableContent)
            let replacementString: String

            if escapableContentString.hasPrefix("#") {

                guard let unescapedNumber = escapableContentString.unescapeAsNumber() else {
                    result += self[delimiterRange.lowerBound ..< semicolonRange.upperBound]
                    cursorPosition = semicolonRange.upperBound
                    continue
                }

                replacementString = unescapedNumber

            } else {

                guard let unescapedCharacter = HTMLUnescapingTable[escapableContentString] else {
                    result += self[delimiterRange.lowerBound ..< semicolonRange.upperBound]
                    cursorPosition = semicolonRange.upperBound
                    continue
                }

                replacementString = unescapedCharacter

            }

            result += replacementString
            cursorPosition = semicolonRange.upperBound

        }

        // Append unprocessed data, if unprocessed data there is
        let tail = self[cursorPosition ..< endIndex]
        result += tail

        return result

    }

    private func unescapeAsNumber() -> String? {

        let isHexadecimal = hasPrefix("#X") || hasPrefix("#x")
        let radix = isHexadecimal ? 16 : 10

        let numberStartIndex = index(startIndex, offsetBy: isHexadecimal ? 2 : 1)
        let numberString = self[numberStartIndex ..< endIndex]

        guard let codePoint = UInt32(numberString, radix: radix),
              let scalar = UnicodeScalar(codePoint) else {
            return nil
        }

        return String(scalar)

    }

}

// MARK: - UnicodeScalar+Escape

extension UnicodeScalar {

    /// Returns the decimal HTML entity for this Unicode scalar.
    public var htmlEscaped: String {
        return "&#" + String(value) + ";"
    }

    /// The scalar escaped for ASCII encoding.
    fileprivate var escapingForASCII: String {
        return isASCII ? escapingIfNeeded : htmlEscaped
    }

    ///
    /// Escapes the scalar only if it needs to be escaped for Unicode pages.
    ///
    /// [Reference](http://wonko.com/post/html-escaping)
    /// 

    fileprivate var escapingIfNeeded: String {

        switch value {
        case 33, 34, 36, 37, 38, 39, 43, 44, 60, 61, 62, 64, 91, 93, 96, 123, 125: return htmlEscaped
        default: return String(self)
        }

    }

}
