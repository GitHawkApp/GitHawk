//
//  IssueLabeledModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

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
    let attributedString: NSAttributedStringSizing

    init(
        id: String,
        actor: String,
        title: String,
        color: String,
        date: Date,
        type: EventType,
        repoOwner: String,
        repoName: String,
        width: CGFloat
        ) {
        self.id = id
        self.actor = actor
        self.title = title
        self.color = color
        self.date = date
        self.type = type
        
        let attributedString = NSMutableAttributedString(
            string: actor,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.dark.color,
                .font: Styles.Text.secondaryBold.preferredFont,
                MarkdownAttribute.username: actor
            ]
        )

        let actionString: String
        switch type {
        case .added: actionString = NSLocalizedString(" added  ", comment: "")
        case .removed: actionString = NSLocalizedString(" removed  ", comment: "")
        }
        attributedString.append(NSAttributedString(
            string: actionString,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.medium.color,
                .font: Styles.Text.secondary.preferredFont
            ]
        ))

        let labelColor = color.color
        attributedString.append(NSAttributedString(
            string: title,
            attributes: [
                .font: Styles.Text.smallTitle.preferredFont,
                .backgroundColor: labelColor,
                .foregroundColor: labelColor.textOverlayColor ?? .black,
                .baselineOffset: 1, // offset for better rounded background colors
                MarkdownAttribute.label: LabelDetails(owner: repoOwner, repo: repoName, label: title)
            ]
        ))

        attributedString.append(NSAttributedString(
            string: "  \(date.agoString)",
            attributes: [
                .font: Styles.Text.secondary.preferredFont,
                .foregroundColor: Styles.Colors.Gray.medium.color,
                MarkdownAttribute.details: DateDetailsFormatter().string(from: date)
            ]
        ))

        self.attributedString = NSAttributedStringSizing(
            containerWidth: width,
            attributedText: attributedString,
            inset: IssueLabeledCell.insets,
            backgroundColor: Styles.Colors.Gray.lighter.color
        )
        
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
