//
//  IssueReferencedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledText
import DateAgo
import StringHelpers

final class IssueReferencedCommitModel: ListDiffable {

    let id: String
    let owner: String
    let repo: String
    let hash: String
    let actor: String
    let date: Date
    let string: StyledTextRenderer

    init(
        id: String,
        owner: String,
        repo: String,
        hash: String,
        actor: String,
        date: Date,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat
        ) {
        self.id = id
        self.owner = owner
        self.repo = repo
        self.hash = hash
        self.actor = actor
        self.date = date

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
            .add(text: NSLocalizedString(" referenced ", comment: ""))
            .save()
            .add(styledText: StyledText(
                text: hash.hashDisplay,
                style: Styles.Text.codeBold.with(attributes: [
                    .foregroundColor: Styles.Colors.Gray.dark.color,
                    MarkdownAttribute.commit: CommitDetails(owner: owner, repo: repo, hash: hash)
                    ])
            ))
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

