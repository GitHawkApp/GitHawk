//
//  IssueDiffHunkModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledText

final class IssueDiffHunkModel: ListDiffable {

    let path: String
    let preview: StyledTextRenderer
    let offset: Int
    private let _diffIdentifier: String

    init(path: String, preview: StyledTextRenderer, offset: Int) {
        self.path = path
        self.preview = preview
        self.offset = offset
        self._diffIdentifier = "\(preview.string)-\(offset)"
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
