//
//  IssueCommentCodeBlockModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentCodeBlockModel: NSObject, ListDiffable {

    let code: NSAttributedStringSizing
    let language: String?

    init(
        code: NSAttributedStringSizing,
        language: String?
        ) {
        self.code = code
        self.language = language
    }

    // MARK: Public API

    var contentSize: CGSize {
        return code.textViewSize(0)
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }

}
