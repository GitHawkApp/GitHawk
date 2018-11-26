//
//  PathCommitModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

struct PathCommitModel: ListSwiftDiffable {

    let oid: String
    let text: StyledTextRenderer
    let commitURL: URL

    // MARK: ListSwiftDiffable

    var identifier: String {
        return oid
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? PathCommitModel else { return false }
        return text.string == value.text.string
    }

}
