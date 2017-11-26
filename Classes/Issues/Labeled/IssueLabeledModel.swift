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
        repoName: String
        ) {
        self.id = id
        self.actor = actor
        self.title = title
        self.color = color
        self.date = date
        self.type = type
        
        // Actor
        
        let actorAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color,
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold,
            MarkdownAttribute.username: actor
        ]
        
        let attributedString = NSMutableAttributedString(string: actor, attributes: actorAttributes)
        
        // Action
        
        let actionAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
            NSAttributedStringKey.font: Styles.Fonts.secondary
        ]
        
        let actionString: String
        
        switch type {
        case .added: actionString = NSLocalizedString(" added  ", comment: "")
        case .removed: actionString = NSLocalizedString(" removed  ", comment: "")
        }
        
        attributedString.append(NSAttributedString(string: actionString, attributes: actionAttributes))
        
        // Label
        
        let labelColor = color.color
        let labelDetails = LabelDetails(owner: repoOwner, repo: repoName, label: title)
        
        let labelAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold,
            NSAttributedStringKey.backgroundColor: labelColor,
            NSAttributedStringKey.foregroundColor: labelColor.textOverlayColor ?? .black,
            MarkdownAttribute.label: labelDetails
        ]
        
        attributedString.append(NSAttributedString(string: title, attributes: labelAttributes))
        
        // Date
        
        let dateAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Styles.Fonts.secondary,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
            MarkdownAttribute.details: DateDetailsFormatter().string(from: date)
        ]
        
        attributedString.append(NSAttributedString(string: "  \(date.agoString)", attributes: dateAttributes))
        
        // Set
        
        self.attributedString = NSAttributedStringSizing(
            containerWidth: 0,
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
