//
//  IssueRequestModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueRequestModel: ListDiffable {

    enum Event {
        case assigned
        case unassigned
        case reviewRequested
        case reviewRequestRemoved
    }

    let id: String
    let actor: String
    let user: String
    let date: Date
    let event: Event
    let attributedText: NSAttributedStringSizing

    init(id: String, actor: String, user: String, date: Date, event: Event, width: CGFloat) {
        self.id = id
        self.actor = actor
        self.user = user
        self.date = date
        self.event = event

        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(
            string: actor,
            attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.dark.color,
                MarkdownAttribute.username: actor
            ]
        ))

        let phrase: String
        switch event {
        case .assigned: phrase = NSLocalizedString(" assigned", comment: "")
        case .unassigned: phrase = NSLocalizedString(" unassigned", comment: "")
        case .reviewRequested: phrase = NSLocalizedString(" requested", comment: "")
        case .reviewRequestRemoved: phrase = NSLocalizedString(" removed", comment: "")
        }
        attributedText.append(NSAttributedString(
            string: phrase,
            attributes: [
                .font: Styles.Text.secondary.preferredFont,
                .foregroundColor: Styles.Colors.Gray.medium.color
            ]
        ))
        attributedText.append(NSAttributedString(
            string: " \(user)",
            attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.dark.color,
                MarkdownAttribute.username: user
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
