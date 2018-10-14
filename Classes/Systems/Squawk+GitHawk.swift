//
//  Squawk+GitHawk.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Squawk

extension Squawk {

    private static var window: UIView? {
        return UIApplication.shared.keyWindow
    }

    private static func triggerHaptic() {
        Haptic.triggerNotification(.error)
    }

    static func errorConfig(text: String) -> Squawk.Configuration {
        return Squawk.Configuration(
            text: text,
            backgroundColor: UIColor.red.withAlphaComponent(0.5),
            insets: UIEdgeInsets(top: Styles.Sizes.rowSpacing, left: Styles.Sizes.gutter, bottom: Styles.Sizes.rowSpacing, right: Styles.Sizes.gutter),
            hintMargin: Styles.Sizes.rowSpacing
        )
    }

    static func showRevokeError(view: UIView? = window) {
        Squawk.shared.show(in: view, config: errorConfig(text: NSLocalizedString("Your access token was revoked.", comment: "")))
        triggerHaptic()
    }

    static func showNetworkError(view: UIView? = window) {
        Squawk.shared.show(in: view, config: errorConfig(text: NSLocalizedString("Cannot connect to GitHub.", comment: "")))
        triggerHaptic()
    }

    static func showGenericError(view: UIView? = window) {
        Squawk.shared.show(in: view, config: errorConfig(text: NSLocalizedString("Something went wrong.", comment: "")))
        triggerHaptic()
    }

    static func show(error: Error?, view: UIView? = window) {
        let text = error?.localizedDescription
            ?? NSLocalizedString("Something went wrong.", comment: "")
        Squawk.shared.show(in: view, config: errorConfig(text: text))
        triggerHaptic()
    }

    static func showPermissionsError(view: UIView? = window) {
        Squawk.shared.show(in: view, config: errorConfig(text: NSLocalizedString("You must request access.", comment: "")))
        triggerHaptic()
    }

    static func showError(message: String, view: UIView? = window) {
        Squawk.shared.show(in: view, config: errorConfig(text: message))
        triggerHaptic()
    }

}
