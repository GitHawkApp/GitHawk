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

    let rowHeight: CGFloat
    let columns: [Column]
    let totalHeight: CGFloat

    init(columns: [Column]) {
        self.columns = columns
        self.rowHeight = columns.reduce(0) { currentRowHeight, column  in
            let maxHeight: CGFloat = column.rows.reduce(0.0) { currentMaxHeight, row in
                let textSize = row.text.computeSize(0)
                return max(currentMaxHeight, textSize.height)
            }
            
            let inset = IssueCommentTableCollectionCell.inset.top + IssueCommentTableCollectionCell.inset.bottom
            return max(currentRowHeight, maxHeight + inset)
        }
        self.totalHeight = CGFloat(columns.first?.rows.count ?? 0) * rowHeight
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
