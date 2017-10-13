//
//  IssueDiffHunkModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueDiffHunkModel: ListDiffable {

    let path: String
    let preview: NSAttributedStringSizing

    init(path: String, preview: NSAttributedStringSizing) {
        self.path = path
        self.preview = preview
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return preview.attributedText.string as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
