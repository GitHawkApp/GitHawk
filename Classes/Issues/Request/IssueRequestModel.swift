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

        self.string = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: contentSizeCategory,
            inset: UIEdgeInsets(
                top: Styles.Sizes.inlineSpacing,
                left: Styles.Sizes.eventGutter,
                bottom: Styles.Sizes.inlineSpacing,
                right: Styles.Sizes.eventGutter
            )
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
