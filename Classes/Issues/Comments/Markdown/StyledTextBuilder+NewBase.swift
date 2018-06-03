//
//  StyledTextBuilder+NewBase.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledTextKit

extension StyledTextBuilder {
    static func markdownBase() -> StyledTextBuilder {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacingBefore = 12
        let attributes: [NSAttributedStringKey: Any] = [
            .foregroundColor: Styles.Colors.Gray.dark.color,
            .paragraphStyle: paragraphStyle,
            .backgroundColor: UIColor.white
        ]
        return StyledTextBuilder(styledText: StyledText(
            style: Styles.Text.body.with(attributes: attributes)
        ))
    }
}
