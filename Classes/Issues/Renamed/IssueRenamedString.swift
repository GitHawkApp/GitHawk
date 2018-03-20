//
//  IssueRenamedString.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledText

func IssueRenamedString(
    previous: String,
    current: String,
    contentSizeCategory: UIContentSizeCategory,
    width: CGFloat
    ) -> StyledTextRenderer {
    let string = StyledTextBuilder(styledText: StyledText(
        text: previous,
        style: Styles.Text.secondaryBold.with(foreground: Styles.Colors.Gray.dark.color)
    ))
        .save()
        .add(styledText: StyledText(text: NSLocalizedString(" to ", comment: ""), style: Styles.Text.secondary))
        .restore()
        .add(text: current)
        .build()
    return StyledTextRenderer(
        string: string,
        contentSizeCategory: contentSizeCategory,
        inset: IssueRenamedCell.titleInset
    )
}
