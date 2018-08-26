//
//  NoNewNotificationSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import Crashlytics

final class NoNewNotificationSectionController: ListSwiftSectionController<String> {

    private let layoutInsets: UIEdgeInsets
    private let loader = InboxZeroLoader()

    init(layoutInsets: UIEdgeInsets) {
        self.layoutInsets = layoutInsets
        super.init()
        loader.load { [weak self] success in
            guard let `self` = self else { return }
            if success {
                self.collectionContext?.performBatch(animated: true, updates: { context in
                    context.reload(self)
                })
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
                configure: {
                    // TODO accessing the value seems to be required for this to compile
                    print($1.value)
                    $0.configure(emoji: latest.emoji, message: latest.message)
                })
        ]
    }

}
