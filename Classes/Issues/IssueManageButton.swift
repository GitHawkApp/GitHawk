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
    if let image = UIImage(named: "")?.withRenderingMode(.alwaysTemplate) {
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = image.size.height / 2
    }
    button.clipsToBounds = true
    button.tintColor = .white
    button.backgroundColor = Styles.Colors.Blue.medium.color
    return button
}
