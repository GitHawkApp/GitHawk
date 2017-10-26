//
//  UINavigationItem+TitleSubtitle.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UINavigationItem {

    func configure(title: String, subtitle: String) {
        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Fonts.bodyBold,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]
        let subtitleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Fonts.secondaryBold,
            .foregroundColor: Styles.Colors.Gray.light.color
        ]

        let title = NSMutableAttributedString(string: title, attributes: titleAttributes)
        title.append(NSAttributedString(string: "\n"))
        title.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))

        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = title
        label.sizeToFit()

        titleView = label
    }

}
