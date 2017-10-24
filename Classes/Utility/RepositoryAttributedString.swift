//
//  RepositoryAttributedString.swift
//  Freetime
//
//  Created by Hesham Salman on 10/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func RepositoryAttributedString(owner: String, name: String) -> NSAttributedString {
    let text = NSMutableAttributedString(string: owner + "/", attributes: ownerAttributes)
    text.append(NSAttributedString(string: name, attributes: nameAttributes))
    return text
}

private var ownerAttributes: [NSAttributedStringKey: Any] {
    return [
        .font: Styles.Fonts.body,
        .foregroundColor: Styles.Colors.Gray.dark.color
    ]
}

private var nameAttributes: [NSAttributedStringKey: Any] {
    return [
        .font: Styles.Fonts.bodyBold,
        .foregroundColor: Styles.Colors.Gray.dark.color
    ]
}
