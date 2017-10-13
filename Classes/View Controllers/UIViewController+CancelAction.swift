//
//  UIViewController+CancelAction.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func cancelAction_onCancel(
        texts: [String?],
        title: String = NSLocalizedString("Unsaved Changes", comment: ""),
        message: String
        ) {
        let dismissBlock = {
            self.dismiss(animated: true)
        }

        // dismiss if all text entries are empty
        let canDismissNow = texts.reduce(true) { $0 && ($1 == nil || $1!.isEmpty) }
        if canDismissNow {
            dismissBlock()
        } else {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addActions([
                AlertAction.goBack(),
                AlertAction.discard { _ in
                    dismissBlock()
                }
                ])
            present(alert, animated: true, completion: nil)
        }
    }

}
