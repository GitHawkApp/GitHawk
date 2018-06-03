//
//  IssueCommentTableModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class IssueCommentTableModel: NSObject, ListDiffable {

    final class Row {
        let string: StyledTextRenderer
        let fill: Bool

        init(string: StyledTextRenderer, fill: Bool) {
            self.string = string
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
