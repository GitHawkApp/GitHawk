//
//  IssueCommentQuoteModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class IssueCommentQuoteModel: NSObject, ListDiffable, ListSwiftDiffable {

    let level: Int
    let string: StyledTextRenderer
    private let _identifier: String

    init(level: Int, string: StyledTextRenderer) {
        self.level = level
        self.string = string
        self._identifier = "\(string.string.hashValue)"
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _identifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return _identifier
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
