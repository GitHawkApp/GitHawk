//
//  IssueCommentQuoteModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentQuoteModel: NSObject, ListDiffable {

    let level: Int
    let quote: NSAttributedStringSizing

    init(level: Int, quote: NSAttributedStringSizing) {
        self.level = level
        self.quote = quote
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return quote.attributedText.string as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
