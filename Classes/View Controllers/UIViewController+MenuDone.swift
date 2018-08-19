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
        if left {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(onMenuDone)
            )
            navigationItem.leftBarButtonItem?.tintColor = Styles.Colors.Gray.light.color
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(onMenuDone)
            )
            navigationItem.rightBarButtonItem?.tintColor = Styles.Colors.Gray.light.color
        }
    }

    @objc func onMenuDone() {
        dismiss(animated: true)
    }

}
