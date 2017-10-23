//
//  ShowMoreDetailsLabel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class ShowMoreDetailsLabel: UILabel {

    var detailText: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)

        isUserInteractionEnabled = true

        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(ShowMoreDetailsLabel.showMenu(recognizer:))
        )
        addGestureRecognizer(longPress)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: Private API

    @objc
    func showMenu(recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .began,
            !detailText.isEmpty else { return }

        becomeFirstResponder()

        let menu = UIMenuController.shared
        menu.menuItems = [
            UIMenuItem(title: detailText, action: #selector(ShowMoreDetailsLabel.empty))
        ]
        menu.setTargetRect(bounds, in: self)
        menu.setMenuVisible(true, animated: true)
    }

    @objc
    func empty() {}

}
