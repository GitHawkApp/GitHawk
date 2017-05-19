//
//  IssueViewModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func createIssueTitleString(issue: Issue, width: CGFloat) -> NSAttributedStringSizing {
    let attributedString = NSAttributedString(
        string: issue.title ?? "",
        attributes: [
            NSFontAttributeName: Styles.Fonts.headline,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark
        ])
    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
        inset: IssueTitleCell.inset
    )
}
