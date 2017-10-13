//
//  Toast+GitHawk.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ToastManager {

    private static func provideHapticFeedback() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    static func errorConfig(text: String) -> ToastViewConfiguration {
        return ToastViewConfiguration(
            text: text,
            backgroundColor: UIColor.red.withAlphaComponent(0.5),
            insets: UIEdgeInsets(top: Styles.Sizes.rowSpacing, left: Styles.Sizes.gutter, bottom: Styles.Sizes.rowSpacing, right: Styles.Sizes.gutter),
            maxWidth: 300,
            buttonVisible: false,
            buttonLeftMargin: Styles.Sizes.columnSpacing,
            hintTopMargin: Styles.Sizes.rowSpacing,
            hintSize: CGSize(width: 40, height: 4),
            cornerRadius: 6,
            borderColor: UIColor(white: 0, alpha: 0.4),
            dismissDuration: 4
        )
    }

    static func showRevokeError() {
        ToastManager.shared.show(config: errorConfig(text: NSLocalizedString("Your access token was revoked.", comment: "")))
        provideHapticFeedback()
    }

    static func showNetworkError() {
        ToastManager.shared.show(config: errorConfig(text: NSLocalizedString("Cannot connect to GitHub.", comment: "")))
        provideHapticFeedback()
    }

    static func showGenericError() {
        ToastManager.shared.show(config: errorConfig(text: NSLocalizedString("Something went wrong.", comment: "")))
        provideHapticFeedback()
    }

    static func showPermissionsError() {
        ToastManager.shared.show(config: errorConfig(text: NSLocalizedString("You must request access.", comment: "")))
        provideHapticFeedback()
    }

    static func showError(message: String) {
        ToastManager.shared.show(config: errorConfig(text: message))
        provideHapticFeedback()
    }

}
