//
//  IssueRenamedString.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledTextKit

func IssueRenamedString(
    previous: String,
    current: String,
    contentSizeCategory: UIContentSizeCategory,
    width: CGFloat
    ) -> StyledTextRenderer {
    let builder = StyledTextBuilder(styledText: StyledText(
        text: previous,
        style: Styles.Text.secondaryBold.with(foreground: Styles.Colors.Gray.dark.color)
    ))
        .save()
        .add(styledText: StyledText(text: NSLocalizedString(" to ", comment: ""), style: Styles.Text.secondary))
        .restore()
        .add(text: current)
    return StyledTextRenderer(
        string: builder.build(),
        contentSizeCategory: contentSizeCategory,
        inset: IssueRenamedCell.titleInset
    ).warm(width: width)
}
