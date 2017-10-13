//
//  IssueLabelSummaryModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabelSummaryModel: ListDiffable {

    let title = NSLocalizedString("Labels:", comment: "")
    let colors: [UIColor]
    let _diffIdentifier: String

    init(colors: [UIColor]) {
        self.colors = colors
        _diffIdentifier = colors.reduce("") { $0 + $1.description }
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueLabelSummaryModel else { return false }
        return title == object.title
    }

}
