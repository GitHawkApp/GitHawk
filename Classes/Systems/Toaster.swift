//
//  Toaster.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Toaster

enum Toaster {

    private static func provideHapticFeedback() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    static func showRevokeError() {
        showError(message: NSLocalizedString("Your access token was revoked.", comment: ""))
    }

    static func showNetworkError() {
        showError(message: NSLocalizedString("Cannot connect to GitHub.", comment: ""))
    }

    static func showGenericError() {
        showError(message: NSLocalizedString("Something went wrong.", comment: ""))
    }

    static func showPermissionsError() {
        showError(message: NSLocalizedString("You must request access.", comment: ""))
    }
    
    static func showError(message: String,
                          textColor: UIColor = UIColor.white,
                          backgroundColor: UIColor = Styles.Colors.Red.medium.color ) {
        let toast = Toast(text: message, duration: Delay.long)
        var bottomInset: CGFloat = 0.0

        if #available(iOS 11, *) {
            let insets = UIApplication.shared.delegate?.window??.safeAreaInsets

            bottomInset = insets?.bottom ?? 0
        }

        toast.view.backgroundColor = backgroundColor
        toast.view.textColor = textColor
        toast.view.bottomOffsetPortrait = 60 + bottomInset
        toast.view.bottomOffsetLandscape = 60 + bottomInset

        toast.show()

        provideHapticFeedback()
    }
}
