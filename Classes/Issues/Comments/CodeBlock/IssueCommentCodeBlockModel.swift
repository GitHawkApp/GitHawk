//
//  IssueCommentCodeBlockModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentCodeBlockModel: NSObject, IGListDiffable {

    let code: NSAttributedStringSizing
    let language: String?

    init(
        code: NSAttributedStringSizing,
        language: String?
        ) {
        self.code = code
        self.language = language
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return isEqual(object)
    }

}
