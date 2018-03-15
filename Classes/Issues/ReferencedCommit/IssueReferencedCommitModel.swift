//
//  IssueReferencedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedCommitModel: ListDiffable {

    let id: String
    let owner: String
    let repo: String
    let hash: String
    let actor: String
    let date: Date
    let attributedText: NSAttributedStringSizing

    init(
        id: String,
        owner: String,
        repo: String,
        hash: String,
        actor: String,
        date: Date,
        width: CGFloat
        ) {
        self.id = id
        self.owner = owner
        self.repo = repo
        self.hash = hash
        self.actor = actor
        self.date = date

        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(
            string: actor,
            attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.dark.color,
                MarkdownAttribute.username: actor
            ]
        ))
        attributedText.append(NSAttributedString(
            string: NSLocalizedString(" referenced ", comment: ""),
            attributes: [
                .font: Styles.Text.secondary.preferredFont,
                .foregroundColor: Styles.Colors.Gray.medium.color,
            ]
        ))
        attributedText.append(NSAttributedString(
            string: hash.hashDisplay,
            attributes: [
                .font: Styles.Text.code.preferredFont.addingTraits(traits: .traitBold),
                .foregroundColor: Styles.Colors.Gray.dark.color,
                MarkdownAttribute.commit: CommitDetails(owner: owner, repo: repo, hash: hash)
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
