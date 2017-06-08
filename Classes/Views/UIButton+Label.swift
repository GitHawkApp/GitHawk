//
//  UIButton+Label.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIButton {

    func setupAsLabel() {
        tintColor = .white
        titleLabel?.font = Styles.Fonts.smallTitle
        layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        clipsToBounds = true
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -Styles.Sizes.columnSpacing, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 2, left: Styles.Sizes.columnSpacing + 2, bottom: 2, right: 4)
    }

    func setStatusIcon(pullRequest: Bool, closed: Bool) {
        let prName = "git-pull-request-small"
        let iconName: String
        if closed {
            iconName = pullRequest ? "issue-closed-small" : prName
        } else {
            iconName = pullRequest ? "issue-opened-small" : prName
        }
        setImage(UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    func setBackgroundColor(closed: Bool) {
        backgroundColor = closed ? Styles.Colors.red : Styles.Colors.green
    }

}
