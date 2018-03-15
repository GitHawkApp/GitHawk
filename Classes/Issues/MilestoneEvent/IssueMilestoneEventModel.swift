//
//  IssueMilestoneEventModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

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
    let attributedText: NSAttributedStringSizing

    init(
        id: String,
        actor: String,
        milestone: String,
        date: Date,
        type: MilestoneType,
        width: CGFloat
        ) {
        self.id = id
        self.actor = actor
        self.milestone = milestone
        self.date = date
        self.type = type

        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(
            string: actor,
            attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.dark.color,
                MarkdownAttribute.username: actor
            ]
        ))
        let action: String
        switch type {
        case .milestoned: action = NSLocalizedString(" added to milestone ", comment: "")
        case .demilestoned: action = NSLocalizedString(" removed from milestone ", comment: "")
        }
        attributedText.append(NSAttributedString(
            string: action,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.medium.color,
                .font: Styles.Text.secondary.preferredFont
            ]
        ))
        attributedText.append(NSAttributedString(
            string: milestone,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.dark.color,
                .font: Styles.Text.secondaryBold.preferredFont
            ]
        ))
        attributedText.append(NSAttributedString(
            string: " \(date.agoString)",
            attributes: [
                .font: Styles.Text.secondary.preferredFont,
                .foregroundColor: Styles.Colors.Gray.medium.color,
                MarkdownAttribute.details: DateDetailsFormatter().string(from: date)
            ]
        ))
        self.attributedText = NSAttributedStringSizing(
            containerWidth: width,
            attributedText: attributedText,
            inset: UIEdgeInsets(
                top: Styles.Sizes.inlineSpacing,
                left: Styles.Sizes.eventGutter,
                bottom: Styles.Sizes.inlineSpacing,
                right: Styles.Sizes.eventGutter
            ),
            backgroundColor: Styles.Colors.background
        )
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
