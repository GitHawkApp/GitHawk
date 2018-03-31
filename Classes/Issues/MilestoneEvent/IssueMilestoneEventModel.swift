//
//  IssueMilestoneEventModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledText

final class IssueMilestoneEventModel: ListDiffable {

    enum MilestoneType {
        case milestoned
        case demilestoned
    }

    let id: String
    let actor: String
    let milestone: String
    let date: Date
    let type: MilestoneType
    let string: StyledTextRenderer

    init(
        id: String,
        actor: String,
        milestone: String,
        date: Date,
        type: MilestoneType,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat
        ) {
        self.id = id
        self.actor = actor
        self.milestone = milestone
        self.date = date
        self.type = type

        let action: String
        switch type {
        case .milestoned: action = NSLocalizedString(" added to milestone ", comment: "")
        case .demilestoned: action = NSLocalizedString(" removed from milestone ", comment: "")
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
            .add(text: action)
            .save()
            .add(styledText: StyledText(
                text: milestone,
                style: Styles.Text.secondaryBold.with(foreground: Styles.Colors.Gray.dark.color)
            ))
            .restore()
            .add(text: " \(date.agoString)", attributes: [MarkdownAttribute.details: DateDetailsFormatter().string(from: date)])

        self.string = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: contentSizeCategory,
            inset: UIEdgeInsets(
                top: Styles.Sizes.inlineSpacing,
                left: Styles.Sizes.eventGutter,
                bottom: Styles.Sizes.inlineSpacing,
                right: Styles.Sizes.eventGutter
            ),
            backgroundColor: Styles.Colors.background
        ).warm(width: width)
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}

