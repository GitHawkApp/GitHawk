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

    struct LabelDetails {
        let id: String
        let title: String
        let color: String
        let date: Date
        let type: EventType
    }

    let id: String
    let actor: String
    let added: [LabelDetails]
    let removed: [LabelDetails]
    let repoOwner: String
    let repoName: String
    let width: CGFloat

    lazy var attributedString: NSAttributedStringSizing = {

        var seenAdded = [String: LabelDetails]()
        var seenRemoved = [String: LabelDetails]()

        let combinedLabels = added + removed

        for label in combinedLabels {
            switch label.type {
            case .added: seenAdded[label.title] = label
            case .removed: seenRemoved[label.title] = label
            }
        }

        let attributedString = NSMutableAttributedString(
            string: actor,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.dark.color,
                .font: Styles.Text.secondaryBold.preferredFont,
                MarkdownAttribute.username: actor
            ]
        )

        if !seenAdded.isEmpty {
            let plainAttributes: [NSAttributedStringKey: Any] = [
                .foregroundColor: Styles.Colors.Gray.medium.color,
                .font: Styles.Text.secondary.preferredFont
            ]
            attributedString.append(NSAttributedString(
                string: NSLocalizedString(" added  ", comment: ""),
                attributes: plainAttributes
            ))
            let spaceString = NSAttributedString(string: " ", attributes: plainAttributes)
            for (title, label) in seenAdded {
                let labelColor = label.color.color
                attributedString.append(NSAttributedString(
                    string: title,
                    attributes: [
                        .font: Styles.Text.smallTitle.preferredFont,
                        .backgroundColor: labelColor,
                        .foregroundColor: labelColor.textOverlayColor ?? .black,
                        .baselineOffset: 1, // offset for better rounded background colors
                        MarkdownAttribute.label: LabelRepoDetails(owner: repoOwner, repo: repoName, label: title)
                    ]
                ))
                attributedString.append(spaceString)
            }
            if !seenRemoved.isEmpty {
                attributedString.append(NSAttributedString(
                    string: "and",
                    attributes: plainAttributes
                ))
            }
        }

        if !seenRemoved.isEmpty {
            let plainAttributes: [NSAttributedStringKey: Any] = [
                .foregroundColor: Styles.Colors.Gray.medium.color,
                .font: Styles.Text.secondary.preferredFont
            ]
            attributedString.append(NSAttributedString(
                string: NSLocalizedString(" removed  ", comment: ""),
                attributes: plainAttributes
            ))
            let spaceString = NSAttributedString(string: " ", attributes: plainAttributes)
            for (title, label) in seenRemoved {
                let labelColor = label.color.color
                attributedString.append(NSAttributedString(
                    string: "\(title) ",
                    attributes: [
                        .font: Styles.Text.smallTitle.preferredFont,
                        .backgroundColor: labelColor,
                        .foregroundColor: labelColor.textOverlayColor ?? .black,
                        .baselineOffset: 1, // offset for better rounded background colors
                        MarkdownAttribute.label: LabelRepoDetails(owner: repoOwner, repo: repoName, label: title)
                    ]
                ))
                attributedString.append(spaceString)
            }
        }

        let lastDate = min(added.last?.date ?? Date(), removed.last?.date ?? Date())

        attributedString.append(NSAttributedString(
            string: " labels \(lastDate.agoString)",
            attributes: [
                .font: Styles.Text.secondary.preferredFont,
                .foregroundColor: Styles.Colors.Gray.medium.color,
                MarkdownAttribute.details: DateDetailsFormatter().string(from: lastDate)
            ]
        ))

        return NSAttributedStringSizing(
            containerWidth: width,
            attributedText: attributedString,
            inset: IssueLabeledCell.insets,
            backgroundColor: Styles.Colors.Gray.lighter.color
        )
    }()

    init(
        actor: String,
        added: [LabelDetails],
        removed: [LabelDetails],
        repoOwner: String,
        repoName: String,
        width: CGFloat
        ) {

        self.actor = actor
        self.added = added
        self.removed = removed
        self.repoOwner = repoOwner
        self.repoName = repoName
        self.width = width
        self.id = (added + removed).reduce("") { $0 + $1.id }

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
