//
//  StatusBar.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import JDStatusBarNotification

struct StatusBar {

    static func showRevokeError() {
        JDStatusBarNotification.show(
            withStatus: NSLocalizedString("Your access token was revoked.", comment: ""),
            dismissAfter: 3,
            styleName: JDStatusBarStyleError
        )
    }

    static func showNetworkError() {
        JDStatusBarNotification.show(
            withStatus: NSLocalizedString("Network connection lost.", comment: ""),
            dismissAfter: 3,
            styleName: JDStatusBarStyleError
        )
    }

}
