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

        fillBuckets(
            rows: models,
            buckets: &buckets,
            rowHeights: &rowHeights,
            fill: fill
        )
    }

    return IssueCommentTableModel(buckets: buckets, rowHeights: rowHeights)
}
