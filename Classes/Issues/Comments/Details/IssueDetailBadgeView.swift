//
//  IssueDetailBadgeView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssueDetailBadgeView: UIImageView {

    init() {
        super.init(frame: .zero)
        image = UIImage(named: "githawk-badge")?.withRenderingMode(.alwaysTemplate)
        tintColor = Styles.Colors.Blue.medium.color

        isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(ShowMoreDetailsLabel.showMenu(recognizer:))
        )
        addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: Private API

    @objc func showMenu(recognizer: UITapGestureRecognizer) {
        becomeFirstResponder()

        let menu = UIMenuController.shared
        menu.menuItems = [
            UIMenuItem(
                title: NSLocalizedString("Sent with GitHawk", comment: ""),
                action: #selector(IssueDetailBadgeView.empty)
            )
        ]
        menu.setTargetRect(bounds, in: self)
        menu.setMenuVisible(true, animated: trueUnlessReduceMotionEnabled)
    }

    @objc func empty() {}

}
