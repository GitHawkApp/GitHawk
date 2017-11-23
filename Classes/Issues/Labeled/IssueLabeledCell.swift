//
//  IssueLabeledCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueLabeledCell: AttributedStringCell {

    // MARK: Public API

    func configure(_ model: IssueLabeledModel) {

        // Actor
        
        let actorAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color,
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold,
            MarkdownAttribute.username: model.actor
        ]
        
        let attributedString = NSMutableAttributedString(string: model.actor, attributes: actorAttributes)
        
        // Action
        
        let actionAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
            NSAttributedStringKey.font: Styles.Fonts.secondary
        ]
        
        let actionString: String
        
        switch model.type {
        case .added: actionString = NSLocalizedString(" added  ", comment: "")
        case .removed: actionString = NSLocalizedString(" removed  ", comment: "")
        }
        
        attributedString.append(NSAttributedString(string: actionString, attributes: actionAttributes))
        
        // Label
        
        let labelColor = model.color.color
        
        let labelAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold,
            NSAttributedStringKey.backgroundColor: labelColor,
            NSAttributedStringKey.foregroundColor: labelColor.textOverlayColor ?? .black,
            MarkdownAttribute.label: model.title
        ]
        
        attributedString.append(NSAttributedString(string: model.title, attributes: labelAttributes))
        
        // Date
        
        let dateAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Styles.Fonts.secondary,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
            MarkdownAttribute.details: DateDetailsFormatter().string(from: model.date)
        ]
        
        attributedString.append(NSAttributedString(string: "  \(model.date.agoString)", attributes: dateAttributes))
        
        // Set
        
        let centerVertical = (Styles.Sizes.labelEventHeight - Styles.Fonts.secondaryBold.lineHeight) / 2
        let inset = UIEdgeInsets(
            top: centerVertical,
            left: Styles.Sizes.eventGutter,
            bottom: centerVertical,
            right: Styles.Sizes.eventGutter
        )
        
        set(attributedText: NSAttributedStringSizing(
            containerWidth: 0,
            attributedText: attributedString,
            inset: inset,
            backgroundColor: Styles.Colors.Gray.lighter.color
        ))
        
    }

}
