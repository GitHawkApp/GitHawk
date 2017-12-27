//
//  RepositoryAttributedString.swift
//  Freetime
//
//  Created by Hesham Salman on 10/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func RepositoryAttributedString(owner: String, name: String) -> NSAttributedString {
    let text = NSMutableAttributedString(string: owner + "/", attributes: Styles.Attributes.body(color: Styles.Colors.Gray.dark.color))
    text.append(NSAttributedString(string: name, attributes: Styles.Attributes.bodyBold(color: Styles.Colors.Gray.dark.color)))
    return text
}
