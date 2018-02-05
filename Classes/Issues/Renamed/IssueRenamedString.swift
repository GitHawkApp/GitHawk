//
//  IssueRenamedString.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func IssueRenamedString(previous: String, current: String, width: CGFloat) -> NSAttributedStringSizing {
    let titleAttributes = [
        NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color,
        NSAttributedStringKey.font: Styles.Text.secondaryBold.preferredFont
    ]
    let dividerAttributes = [
        NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
        NSAttributedStringKey.font: Styles.Text.secondary.preferredFont
    ]
    let text = NSMutableAttributedString(string: previous, attributes: titleAttributes)
    text.append(NSAttributedString(string: NSLocalizedString(" to ", comment: ""), attributes: dividerAttributes))
    text.append(NSAttributedString(string: current, attributes: titleAttributes))
        return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: text,
        inset: IssueRenamedCell.titleInset,
        backgroundColor: Styles.Colors.background
    )
}
