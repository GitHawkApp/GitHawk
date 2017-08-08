//
//  StatusBar.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import JDStatusBarNotification

enum StatusBar {
    
    private static func provideHapticFeedback() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    static func showRevokeError() {
        JDStatusBarNotification.show(
            withStatus: NSLocalizedString("Your access token was revoked.", comment: ""),
            dismissAfter: 3,
            styleName: JDStatusBarStyleError
        )
        provideHapticFeedback()
    }

    static func showNetworkError() {
        JDStatusBarNotification.show(
            withStatus: NSLocalizedString("Cannot connect to GitHub.", comment: ""),
            dismissAfter: 3,
            styleName: JDStatusBarStyleError
        )
        provideHapticFeedback()
    }

    static func showGenericError() {
        JDStatusBarNotification.show(
            withStatus: NSLocalizedString("Something went wrong.", comment: ""),
            dismissAfter: 3,
            styleName: JDStatusBarStyleError
        )
        provideHapticFeedback()
    }

}
