//
//  IssueReferencedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit
import DateAgo

final class IssueReferencedModel: ListDiffable {

    enum State: Int {
        case open
        case closed
        case merged
    }

    let id: String
    let owner: String
    let repo: String
    let number: Int
    let pullRequest: Bool
    let state: State
    let date: Date
    let title: String
    let actor: String
    let string: StyledTextRenderer

    init(
        id: String,
        owner: String,
        repo: String,
        number: Int,
        pullRequest: Bool,
        state: State,
        date: Date,
        title: String,
        actor: String,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat
        ) {
        self.id = id
        self.owner = owner
        self.repo = repo
        self.number = number
        self.pullRequest = pullRequest
        self.state = state
        self.date = date
        self.title = title
        self.actor = actor

        let issueDetailsModel = IssueDetailsModel(
        owner: actor,
        repo: repo,
        number: number
        )

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
            .add(text: date.agoString(.long), attributes: [MarkdownAttribute.details: DateDetailsFormatter().string(from: date)])
            .restore()
            .add(text: "\n")
            .save()
            .add(styledText: StyledText(text: title, style: Styles.Text.secondaryBold.with(attributes: [MarkdownAttribute.issue: issueDetailsModel]) ))
            .restore()
            .add(text: " #\(number)", attributes: [MarkdownAttribute.issue: issueDetailsModel])

        self.string = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: contentSizeCategory,
            inset: IssueReferencedCell.inset
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
