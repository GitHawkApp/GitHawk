//
//  IssueCommentTableModel+Models.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import StyledText

class TableBucket {
    var rows = [IssueCommentTableModel.Row]()
    var maxWidth: CGFloat = 0
    var maxHeight: CGFloat = 0
}

func fillBuckets(
    rows: [StyledTextRenderer],
    buckets: inout [TableBucket],
    rowHeights: inout [CGFloat],
    fill: Bool
    ) {
    var maxHeight: CGFloat = 0

    // prepopulate the buckets in case this is the first pass
    while buckets.count < rows.count {
        buckets.append(TableBucket())
    }

    // move text models from a row collection and place into column
    for (i, cell) in rows.enumerated() {
        let bucket = buckets[i]
        bucket.rows.append(IssueCommentTableModel.Row(string: cell, fill: fill))

        // adjust the max width of each column using whatever is the largest so all cells are the same width
        let size = cell.viewSize(in: 0)
        bucket.maxWidth = max(bucket.maxWidth, size.width)
        maxHeight = max(maxHeight, size.height)
    }

    rowHeights.append(ceil(maxHeight))
}

extension IssueCommentTableModel {
    convenience init(buckets: [TableBucket], rowHeights: [CGFloat]) {
        self.init(
            columns: buckets.map { IssueCommentTableModel.Column(width: $0.maxWidth, rows: $0.rows) },
            rowHeights: rowHeights
        )
    }
}
