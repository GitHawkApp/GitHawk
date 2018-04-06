//
//  MMElement+Table.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import MMMarkdown
import HTMLString
import StyledText

private typealias Row = IssueCommentTableModel.Row
private class TableBucket {
    var rows = [Row]()
    var maxWidth: CGFloat = 0
    var maxHeight: CGFloat = 0
}

private func buildAttributedString(
    markdown: String,
    element: MMElement,
    builder: StyledTextBuilder
    ) {
    switch element.type {
    case .none, .entity:
        if let substr = markdown.substring(with: element.range) {
            builder.add(text: substr.removingHTMLEntities)
        }
    default:
        builder.save()
        defer { builder.restore() }
        PushAttributes(element: element, builder: builder, listLevel: 0)
        for child in element.children {
            buildAttributedString(
                markdown: markdown,
                element: child,
                builder: builder
            )
        }
    }
}

private func rowModels(
    markdown: String,
    element: MMElement,
    isHeader: Bool,
    fill: Bool,
    contentSizeCategory: UIContentSizeCategory
    ) -> [StyledTextRenderer] {

    var results = [StyledTextRenderer]()
    let backgroundColor = fill ? Styles.Colors.Gray.lighter.color : .white
    let style = isHeader ? Styles.Text.bodyBold : Styles.Text.body

    for child in element.children {
        guard child.type == .tableRowCell || child.type == .tableHeaderCell else { continue }

        let builder = StyledTextBuilder(styledText: StyledText(
            style: style.with(foreground: Styles.Colors.Gray.dark.color, background: backgroundColor)
        ))
        buildAttributedString(
            markdown: markdown,
            element: child,
            builder: builder
        )

        results.append(StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: contentSizeCategory,
            inset: IssueCommentTableCollectionCell.inset,
            backgroundColor: backgroundColor
        ))
    }

    return results
}

func CreateTable(
    element: MMElement,
    markdown: String,
    contentSizeCategory: UIContentSizeCategory
    ) -> IssueCommentTableModel {
    guard element.type == .table else { fatalError("Calling table on non table element") }

    var buckets = [TableBucket]()

    // track the tallest row while building each column
    var rowHeights = [CGFloat]()
    var rowCount = 0

    for row in element.children {
        switch row.type {
        case .tableRow:
            rowCount += 1
        default: continue
        }

        let fill = rowCount > 0 && rowCount % 2 == 0
        let models = rowModels(
            markdown: markdown,
            element: row,
            isHeader: row.type == .tableHeader,
            fill: fill,
            contentSizeCategory: contentSizeCategory
        )

        var maxHeight: CGFloat = 0

        // prepopulate the buckets in case this is the first pass
        while buckets.count < models.count {
            buckets.append(TableBucket())
        }

        // move text models from a row collection and place into column
        for (i, model) in models.enumerated() {
            let bucket = buckets[i]
            bucket.rows.append(Row(string: model, fill: fill))

            // adjust the max width of each column using whatever is the largest so all cells are the same width
            let size = model.viewSize(width: 0)
            bucket.maxWidth = max(bucket.maxWidth, size.width)
            maxHeight = max(maxHeight, size.height)
        }

        rowHeights.append(ceil(maxHeight))
    }

    return IssueCommentTableModel(
        columns: buckets.map { IssueCommentTableModel.Column(width: $0.maxWidth, rows: $0.rows) },
        rowHeights: rowHeights
    )
}
