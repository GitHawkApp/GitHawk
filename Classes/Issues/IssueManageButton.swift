//
//  IssueManageButton.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

func IssueManageButton() -> UIButton {
    let button = UIButton()
    if let image = UIImage(named: "three-bars")?.withRenderingMode(.alwaysTemplate) {
        button.setImage(image, for: .normal)
    }
    button.tintColor = .white
    button.backgroundColor = Styles.Colors.Blue.medium.color
    let width = Styles.Sizes.tableCellHeight
    button.frame = CGRect(
        origin: .zero,
        size: CGSize(width: width, height: width)
    )
    button.layer.cornerRadius = width / 2
    button.layer.shadowOpacity = 0.12
    button.layer.shadowOffset = CGSize(width: 0, height: 2)
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowRadius = 4
    button.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
    button.layer.borderWidth = 1
    button.accessibilityLabel = NSLocalizedString("Show options", comment: "")
    return button
}
