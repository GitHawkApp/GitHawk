//
//  UINavigationItem+TitleSubtitle.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UINavigationItem {

    func configure(filePath: FilePath) {
        configure(title: filePath.current, subtitle: filePath.basePath)
    }

    func configure(title: String?, subtitle: String?) {
        guard let title = title else { return }

        guard let subtitle = subtitle, !subtitle.isEmpty else {
            self.title = title
            return
        }

        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.bodyBold.preferredFont,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]
        let subtitleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.secondaryBold.preferredFont,
            .foregroundColor: Styles.Colors.Gray.light.color
        ]

        let attributedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        attributedTitle.append(NSAttributedString(string: "\n"))
        attributedTitle.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))

        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedTitle
        label.lineBreakMode = .byTruncatingHead
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()

        titleView = label
    }

}
