//
//  UIViewController+MenuDone.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/18/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func addMenuDoneButton(left: Bool = false) {
        let buttonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(onMenuDone)
        )
        buttonItem.tintColor = Styles.Colors.Gray.light.color
        if left {
            navigationItem.leftBarButtonItem = buttonItem
        } else {
            navigationItem.rightBarButtonItem = buttonItem
        }
    }

    @objc func onMenuDone() {
        dismiss(animated: true)
    }

}
