//
//  IssueRequestModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import StyledTextKit
import DateAgo

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
    let string: StyledTextRenderer

    init(
        id: String,
        actor: String,
        user: String,
        date: Date,
        event: Event,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat
        ) {
        self.id = id
        self.actor = actor
        self.user = user
        self.date = date
        self.event = event

        let styledString: StyledTextString
        if actor == user {
            styledString = IssueRequestModel.buildSelfString(
                user: actor,
                date: date,
                event: event
            )
        } else {
            styledString = IssueRequestModel.buildString(
                actor: actor,
                user: user,
                date: date,
                event: event
            )
        }

        self.string = StyledTextRenderer(
            string: styledString,
            contentSizeCategory: contentSizeCategory,
            inset: UIEdgeInsets(
                top: Styles.Sizes.inlineSpacing,
                left: 0,
                bottom: Styles.Sizes.inlineSpacing,
                right: 0
            )
        ).warm(width: width)
    }

    static private func buildSelfString(
        user: String,
        date: Date,
        event: Event
    ) -> StyledTextString {
        let phrase: String
        switch event {
        case .assigned: phrase = NSLocalizedString(" self-assigned this", comment: "")
        case .unassigned: phrase = NSLocalizedString(" removed their assignment", comment: "")
        case .reviewRequested: phrase = NSLocalizedString(" self-requested a review", comment: "")
        case .reviewRequestRemoved: phrase = NSLocalizedString(" removed their request for review", comment: "")
        }

        let builder = StyledTextBuilder(styledText: StyledText(
            style: Styles.Text.secondary.with(foreground: Styles.Colors.Gray.medium.color)
        ))
            .save()
            .add(styledText: StyledText(text: user, style: Styles.Text.secondaryBold.with(attributes: [
                MarkdownAttribute.username: user,
                .foregroundColor: Styles.Colors.Gray.dark.color
                ])
            ))
            .restore()
            .add(text: phrase)
            .add(text: " \(date.agoString(.long))", attributes: [MarkdownAttribute.details: DateDetailsFormatter().string(from: date)])

        return builder.build()
    }

    static private func buildString(
        actor: String,
        user: String,
        date: Date,
        event: Event
    ) -> StyledTextString {

        let phrase: String
        switch event {
        case .assigned: phrase = NSLocalizedString(" assigned", comment: "")
        case .unassigned: phrase = NSLocalizedString(" unassigned", comment: "")
        case .reviewRequested: phrase = NSLocalizedString(" requested", comment: "")
        case .reviewRequestRemoved: phrase = NSLocalizedString(" removed", comment: "")
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
            .add(text: phrase)
            .save()
            .add(styledText: StyledText(text: " \(user)", style: Styles.Text.secondaryBold))
            .restore()
            .add(text: " \(date.agoString(.long))", attributes: [MarkdownAttribute.details: DateDetailsFormatter().string(from: date)])

        return builder.build()
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
