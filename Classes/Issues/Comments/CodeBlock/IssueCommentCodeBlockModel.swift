//
//  IssueCommentCodeBlockModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class IssueCommentCodeBlockModel: NSObject, ListDiffable {

    let code: StyledTextRenderer
    let language: String?

    init(
        code: StyledTextRenderer,
        language: String?
        ) {
        self.code = code
        self.language = language
    }

    // MARK: Public API

    var contentSize: CGSize {
        return code.viewSize(in: 0)
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }

}
