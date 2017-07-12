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
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
        NSFontAttributeName: Styles.Fonts.bodyBold
    ]
    let dividerAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.medium.color,
        NSFontAttributeName: Styles.Fonts.body
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
