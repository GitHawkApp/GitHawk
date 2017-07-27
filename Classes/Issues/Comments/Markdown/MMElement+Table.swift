//
//  MMElement+Table.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import MMMarkdown

private typealias Row = IssueCommentTableModel.Row
private class TableBucket {
    var rows = [Row]()
    var maxWidth: CGFloat = 0
}

private func buildAttributedString(
    markdown: String,
    element: MMElement,
    attributes: [String: Any],
    attributedString: NSMutableAttributedString
    ) {
    switch element.type {
    case .none, .entity:
        if let substr = markdown.substring(with: element.range) {
            attributedString.append(NSAttributedString(string: substr, attributes: attributes))
        }
    default:
        let childAttributes = PushAttributes(element: element, current: attributes, listLevel: 0)
        for child in element.children {
            buildAttributedString(
                markdown: markdown,
                element: child,
                attributes: childAttributes,
                attributedString: attributedString
            )
        }
    }
}

private func rowModels(
    markdown: String,
    element: MMElement,
    attributes: [String: Any],
    fill: Bool
    ) -> [NSAttributedStringSizing] {

    var results = [NSAttributedStringSizing]()

    for child in element.children {
        guard child.type == .tableRowCell || child.type == .tableHeaderCell else { continue }

        let attributedString = NSMutableAttributedString()
        buildAttributedString(
            markdown: markdown,
            element: child,
            attributes: attributes,
            attributedString: attributedString
        )

        results.append(NSAttributedStringSizing(
            containerWidth: 0,
            attributedText: attributedString,
            inset: IssueCommentTableCollectionCell.inset,
            backgroundColor: fill ? Styles.Colors.Gray.lighter.color : .white
        ))
    }

    return results
}

func CreateTable(element: MMElement, markdown: String) -> IssueCommentTableModel {
    guard element.type == .table else { fatalError("Calling table on non table element") }

    var buckets = [TableBucket]()

    var baseAttributes: [String: Any] = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
        NSBackgroundColorAttributeName: UIColor.white,
        ]

    var rowCount = 0

    for row in element.children {
        switch row.type {
        case .tableHeader:
            baseAttributes[NSFontAttributeName] = Styles.Fonts.bodyBold
        case .tableRow:
            rowCount += 1
            baseAttributes[NSFontAttributeName] = Styles.Fonts.body
        default: continue
        }

        let fill = rowCount > 0 && rowCount % 2 == 0

        baseAttributes[NSBackgroundColorAttributeName] = fill ? Styles.Colors.Gray.lighter.color : .white

        let models = rowModels(markdown: markdown, element: row, attributes: baseAttributes, fill: fill)

        // prepopulate the buckets in case this is the first pass
        while buckets.count < models.count {
            buckets.append(TableBucket())
        }

        // move text models from a row collection and place into column
        for (i, model) in models.enumerated() {
            let bucket = buckets[i]
            bucket.rows.append(Row(text: model, fill: fill))

            // adjust the max width of each column using whatever is the largest so all cells are the same width
            bucket.maxWidth = max(bucket.maxWidth, model.textViewSize(0).width)
        }
    }

    return IssueCommentTableModel(
        columns: buckets.map { IssueCommentTableModel.Column(width: $0.maxWidth, rows: $0.rows) }
    )
}
