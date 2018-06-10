//
//  CreateNotificationTitle.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import StyledTextKit

func CreateNotification(title: String, width: CGFloat, contentSizeCategory: UIContentSizeCategory) -> StyledTextRenderer {
    // TODO add owner/repo #
    let builder = StyledTextBuilder(styledText: StyledText(
        text: title,
        style: Styles.Text.body
    ))
        .add(attributes: [.foregroundColor: Styles.Colors.Gray.dark.color])
    return StyledTextRenderer(
        string: builder.build(),
        contentSizeCategory: contentSizeCategory,
        inset: NotificationCell2.inset
    )
}
