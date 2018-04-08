//
//  IssueCommentQuoteModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledText

final class IssueCommentQuoteModel: NSObject, ListDiffable {

    let level: Int
    let string: StyledTextRenderer

    init(level: Int, string: StyledTextRenderer) {
        self.level = level
        self.string = string
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return string.string.hashValue as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
