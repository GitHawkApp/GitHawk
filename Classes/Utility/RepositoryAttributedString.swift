//
//  RepositoryAttributedString.swift
//  Freetime
//
//  Created by Hesham Salman on 10/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func RepositoryAttributedString(owner: String, name: String) -> NSAttributedString {
    let ownerAttributes: [NSAttributedStringKey: Any] = [
        .font: Styles.Fonts.body,
        .foregroundColor: Styles.Colors.Gray.dark.color
    ]

    let nameAttributes: [NSAttributedStringKey: Any] = [
        .font: Styles.Fonts.bodyBold,
        .foregroundColor: Styles.Colors.Gray.dark.color
    ]

    let text = NSMutableAttributedString(string: owner + "/", attributes: ownerAttributes)
    text.append(NSAttributedString(string: name, attributes: nameAttributes))
    return text
}
