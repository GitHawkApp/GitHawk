//
//  IssueCommentQuoteModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentQuoteModel: NSObject, IGListDiffable {

    let quote: NSAttributedStringSizing

    init(quote: NSAttributedStringSizing) {
        self.quote = quote
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return quote.attributedText.string as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }

}
