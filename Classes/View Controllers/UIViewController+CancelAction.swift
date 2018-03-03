//
//  UIViewController+CancelAction.swift
//  Freetime
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
            self.dismiss(animated: trueUnlessReduceMotionEnabled)
        }

        // dismiss if all text entries are empty
        let canDismissNow = texts.containsAll { $0 == nil || $0!.isEmpty }
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
            present(alert, animated: trueUnlessReduceMotionEnabled)
        }
    }

}
