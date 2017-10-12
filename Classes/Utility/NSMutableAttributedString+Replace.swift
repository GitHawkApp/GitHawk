//
//  NSMutableAttributedString+Replace.swift
//  Freetime
//
//  Created by Weyert de Boer on 12/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

// Adapted from: https://stackoverflow.com/a/35770826
extension NSMutableAttributedString {
    enum SearchMode {
        case first, all, last
    }

    func addAttributes(for searchString: String, attributes: [NSAttributedStringKey : Any], mode: SearchMode = .all) {
        let inputLength = self.string.count
        let searchLength = searchString.count
        var range = NSRange(location: 0, length: self.length)
        var rangeCollection = [NSRange]()

        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: searchString, options: [], range: range)
            if range.location != NSNotFound {
                let lineRange = NSRange(location: range.location, length: searchLength)

                switch mode {
                case .first:
                    self.addAttributes(attributes, range: lineRange)
                    return
                case .all:
                    self.addAttributes(attributes, range: lineRange)
                    break
                case .last:
                    rangeCollection.append(range)
                    break
                }

                range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
            }
        }

        switch mode {
        case .last:
            let indexOfLast = rangeCollection.count - 1
            self.addAttributes(attributes, range: rangeCollection[indexOfLast])
            break
        default:
            break
        }
    }
}
