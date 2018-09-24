//
//  NoNewNotificationSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class NoNewNotificationSectionController: ListSwiftSectionController<String> {

    private let layoutInsets: UIEdgeInsets
    private let loader = InboxZeroLoader()
    weak var reviewGitHubAccessDelegate: ReviewGitHubAccessDelegate?

    init(layoutInsets: UIEdgeInsets, reviewGitHubAccessDelegate: ReviewGitHubAccessDelegate) {
        self.layoutInsets = layoutInsets
        super.init()
        self.reviewGitHubAccessDelegate = reviewGitHubAccessDelegate
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
                    $0.configure(emoji: latest.emoji,
                                 message: latest.message,
                                 reviewGitHubAccessDelegate: strongSelf.reviewGitHubAccessDelegate
                    )
                })
        ]
    }

}
