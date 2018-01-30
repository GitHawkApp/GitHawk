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
    let preview: NSAttributedStringSizing
    let offset: Int

    init(path: String, preview: NSAttributedStringSizing, offset: Int) {
        self.path = path
        self.preview = preview
        self.offset = offset
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "\(preview.attributedText.string)-\(offset)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
