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

    final class Row {
        let text: NSAttributedStringSizing
        let fill: Bool

        init(text: NSAttributedStringSizing, fill: Bool) {
            self.text = text
            self.fill = fill
        }

    }

    final class Column {
        let width: CGFloat
        let rows: [Row]

        init(width: CGFloat, rows: [Row]) {
            self.width = width
            self.rows = rows
        }
    }

    let columns: [Column]
    let rowHeights: [CGFloat]

    init(columns: [Column], rowHeights: [CGFloat]) {
        self.columns = columns
        self.rowHeights = rowHeights
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
