//
//  IssueLabeledModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledText

final class IssueLabeledModel: ListDiffable {

    enum EventType {
        case added
        case removed
    }

    let id: String
    let actor: String
    let title: String
    let color: String
    let date: Date
    let type: EventType
    let string: StyledTextRenderer

    init(
        id: String,
        actor: String,
        title: String,
        color: String,
        date: Date,
        type: EventType,
        repoOwner: String,
        repoName: String,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat
        ) {
        self.id = id
        self.actor = actor
        self.title = title
        self.color = color
        self.date = date
        self.type = type

        let labelColor = color.color
        let actionString: String
        switch type {
        case .added: actionString = NSLocalizedString(" added  ", comment: "")
        case .removed: actionString = NSLocalizedString(" removed  ", comment: "")
        }

        let builder = StyledTextBuilder(styledText: StyledText(
            style: Styles.Text.secondary.with(foreground: Styles.Colors.Gray.medium.color)
        ))
            .save()
            .add(styledText: StyledText(text: actor, style: Styles.Text.secondaryBold.with(attributes: [
                MarkdownAttribute.username: actor,
                .foregroundColor: Styles.Colors.Gray.dark.color
                ])
            ))
            .restore()
            .add(text: actionString)
            .save()
            .add(styledText: StyledText(text: title, style: Styles.Text.smallTitle.with(attributes: [
                .backgroundColor: labelColor,
                .foregroundColor: labelColor.textOverlayColor ?? .black,
                .baselineOffset: 1, // offset for better rounded background colors
                MarkdownAttribute.label: LabelDetails(owner: repoOwner, repo: repoName, label: title)
                ]
            )))
            .restore()
            .add(text: " \(date.agoString)", attributes: [MarkdownAttribute.details: DateDetailsFormatter().string(from: date)])

        self.string = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: contentSizeCategory,
            inset: IssueLabeledCell.insets,
            backgroundColor: Styles.Colors.Gray.lighter.color,
            layoutManager: LabelLayoutManager()
        ).warm(width: width)
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // assume that if ids match then its the same object
        return true
    }

}
