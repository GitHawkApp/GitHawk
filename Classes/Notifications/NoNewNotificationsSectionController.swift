//
//  NoNewNotificationSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class NoNewNotificationSectionController: ListSwiftSectionController<String>,
NoNewNotificationsCellReviewAccessDelegate {

    private let layoutInsets: UIEdgeInsets
    private let loader = InboxZeroLoader()

    init(layoutInsets: UIEdgeInsets) {
        self.layoutInsets = layoutInsets
        super.init()
        loader.load { [weak self] success in
            if success {
                self?.update()
            }
        }
    }

    override func createBinders(from value: String) -> [ListBinder] {
        let latest = loader.message()
        return [
            binder(
                latest.emoji,
                cellType: ListCellType.class(NoNewNotificationsCell.self),
                size: { [layoutInsets] in
                    return CGSize(
                        width: $0.collection.containerSize.width,
                        height: $0.collection.containerSize.height - layoutInsets.top - layoutInsets.bottom
                    )
            },
                configure: { [weak self] in
                    guard let strongSelf = self else { return }
                    // TODO accessing the value seems to be required for this to compile
                    print($1.value)
                    $0.configure(
                        emoji: latest.emoji,
                        message: latest.message,
                        reviewGitHubAccessDelegate: strongSelf
                    )
                })
        ]
    }

    // MARK: NoNewNotificationsCellReviewAccessDelegate

    func didTapReviewAccess(cell: NoNewNotificationsCell) {
        //copied/pasted from SettingsViewController... could consolidate
        guard let url = URL(string: "https://github.com/settings/connections/applications/\(Secrets.GitHub.clientId)")
            else { fatalError("Should always create GitHub issue URL") }
        // iOS 11 login uses SFAuthenticationSession which shares credentials with Safari.app
        UIApplication.shared.open(url)
    }

}
