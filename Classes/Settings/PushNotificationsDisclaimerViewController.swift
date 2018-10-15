//
//  PushNotificationsDisclaimerViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class PushNotificationsDisclaimerViewController: UIViewController {

    private let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(onDone)
        )
        title = NSLocalizedString("Push Notifications", comment: "")

        textView.textContainerInset = UIEdgeInsets(
            top: 0,
            left: Styles.Sizes.gutter,
            bottom: Styles.Sizes.gutter,
            right: Styles.Sizes.gutter
        )
        textView.isEditable = false

        textView.font = Styles.Text.body.preferredFont
        textView.textColor = Styles.Colors.Gray.dark.color
        textView.text = NSLocalizedString("GitHawk uses iOS background fetch to periodically check for new GitHub notifications. When there is new content available, GitHawk sends alerts with local notifications.\n\nThis setup requires Background App Refresh be enabled to work. Enable this feature in Settings > General > Background App Refresh.\n\nAt GitHawk, we value your privacy and data. Real-time push notifications require sending your authentication data to servers, which is a security risk we want to avoid.", comment: "")
        view.addSubview(textView)

        preferredContentSize = textView.sizeThatFits(CGSize(
            width: min(320, UIScreen.main.bounds.width - Styles.Sizes.rowSpacing * 2),
            height: CGFloat.greatestFiniteMagnitude
        ))
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textView.frame = view.bounds
    }

    @objc private func onDone() {
        dismiss(animated: true)
    }

}
