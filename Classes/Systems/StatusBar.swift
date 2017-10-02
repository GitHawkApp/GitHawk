//
//  StatusBar.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import JDStatusBarNotification
import Toaster

enum StatusBar {
    
    private static func provideHapticFeedback() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    static func showRevokeError() {
        Toast(text: NSLocalizedString("Your access token was revoked.", comment: ""),
              duration: Delay.long).show()

        provideHapticFeedback()
    }

    static func showNetworkError() {
        Toast(text: NSLocalizedString("Cannot connect to GitHub.", comment: ""),
              duration: Delay.long).show()

        provideHapticFeedback()
    }

    static func showGenericError() {
        Toast(text: NSLocalizedString("Something went wrong.", comment: ""),
              duration: Delay.long).show()

        provideHapticFeedback()
    }

    static func showPermissionsError() {
        Toast(text: NSLocalizedString("You must request access.", comment: ""),
              duration: Delay.long).show()

        provideHapticFeedback()
    }
    
    static func showError(message: String) {
        Toast(text: message, duration: Delay.long).show()

        JDStatusBarNotification.show(
            withStatus: message,
            dismissAfter: 3,
            styleName: JDStatusBarStyleError
        )
        provideHapticFeedback()
    }

}
