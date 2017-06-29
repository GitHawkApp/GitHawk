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
        accessibilityTraits = UIAccessibilityTraitNone
        tintColor = .white
        titleLabel?.font = Styles.Fonts.smallTitle
        layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        clipsToBounds = true
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -Styles.Sizes.columnSpacing, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 2, left: Styles.Sizes.columnSpacing + 2, bottom: 2, right: 4)
    }

    func config(pullRequest: Bool, status: IssueStatus) {

        let prName = "git-pull-request-small"

        let icon: String
        let color: UIColor
        switch status {
        case .closed:
            icon = pullRequest ? prName : "issue-closed-small"
            color = Styles.Colors.red.color
        case .open:
            icon = pullRequest ? prName : "issue-opened-small"
            color = Styles.Colors.green.color
        case .merged:
            icon = "git-merge-small"
            color = Styles.Colors.purple.color
        }
        setImage(UIImage(named: icon)?.withRenderingMode(.alwaysTemplate), for: .normal)
        backgroundColor = color
    }

}
