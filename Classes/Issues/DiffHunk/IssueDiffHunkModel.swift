//
//  IssueDiffHunkModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueDiffHunkModel: ListDiffable {

    let path: String
    let diff: String
    let hunk: NSAttributedStringSizing

    init(path: String, diff: String, hunk: NSAttributedStringSizing) {
        self.path = path
        self.diff = diff
        self.hunk = hunk
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return hunk.attributedText.string as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
