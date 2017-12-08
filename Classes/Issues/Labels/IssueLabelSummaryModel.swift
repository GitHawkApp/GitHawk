//
//  IssueLabelSummaryModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabelSummaryModel: ListDiffable {

    let labels: [RepositoryLabel]
    let _diffIdentifier: String
    
    
    // quicker comparison for diffing rather than scanning the labels array
    private let labelSummary: String

    init(labels: [RepositoryLabel]) {
        self.labels = labels
        labelSummary = labels.reduce("", { $0 + $1.name })
        
        let colors = labels.map { UIColor.fromHex($0.color) }
        _diffIdentifier = colors.reduce("") { $0 + $1.description }
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueLabelSummaryModel else { return false }
        return labelSummary == object.labelSummary
    }

}
