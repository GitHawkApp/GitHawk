//
//  IssueCommentTableModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentTableModel: NSObject, ListDiffable {

    struct Column {
        let width: CGFloat
        let height = Styles.Sizes.labelEventHeight
        let items: [NSAttributedStringSizing]
    }

    let columns: [Column]
    let totalHeight: CGFloat

    init(columns: [Column]) {
        self.columns = columns
        self.totalHeight = columns.reduce(0, { $0 + $1.height })
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
