//
//  IssueReferencedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

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
    let attributedText: NSAttributedStringSizing

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

        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(
            string: actor,
            attributes: [
                .font: Styles.Fonts.secondaryBold,
                .foregroundColor: Styles.Colors.Gray.medium.color,
                // TODO: enable once #1125 is fixed
//                MarkdownAttribute.username: actor
            ]
        ))
        attributedText.append(NSAttributedString(
            string: NSLocalizedString(" referenced ", comment: ""),
            attributes: [
                .font: Styles.Fonts.secondary,
                .foregroundColor: Styles.Colors.Gray.medium.color,
                ]
        ))
        attributedText.append(NSAttributedString(
            string: date.agoString,
            attributes: [
                .font: Styles.Fonts.secondary,
                .foregroundColor: Styles.Colors.Gray.medium.color,
                MarkdownAttribute.details: DateDetailsFormatter().string(from: date)
            ]
        ))
        attributedText.append(NSAttributedString(string: "\n"))
        attributedText.append(NSAttributedString(
            string: title,
            attributes: [
                .font: Styles.Fonts.secondaryBold,
                .foregroundColor: Styles.Colors.Gray.dark.color,
            ]
        ))
        attributedText.append(NSAttributedString(
            string: " #\(number)",
            attributes: [
                .font: Styles.Fonts.secondary,
                .foregroundColor: Styles.Colors.Gray.medium.color,
            ]
        ))
        self.attributedText = NSAttributedStringSizing(
            containerWidth: width,
            attributedText: attributedText,
            inset: IssueReferencedCell.inset,
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
