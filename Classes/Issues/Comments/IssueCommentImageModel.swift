//
//  IssueCommentImageModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentImageModel: IGListDiffable {

    let url: URL

    init(url: URL) {
        self.url = url
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return url as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        // lazy, assuming anything matching this url as the diffidentifier is the same object
        return true
    }

}
