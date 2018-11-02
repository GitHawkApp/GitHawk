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
    private let client = NotificationEmptyMessageClient()

    enum State {
        case loading
        case success(NotificationEmptyMessageClient.Message)
        case error
    }
    private var state: State = .loading

    init(layoutInsets: UIEdgeInsets) {
        self.layoutInsets = layoutInsets
        super.init()
        client.fetch { [weak self] (result) in
            self?.handleFinished(result)
        }
    }

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(NoNewNotificationsCell.self),
                size: { [layoutInsets] in
                    return CGSize(
                        width: $0.collection.containerSize.width,
                        height: $0.collection.containerSize.height - layoutInsets.top - layoutInsets.bottom
                    )
            },
                configure: { [weak self] in
                    // TODO accessing the value seems to be required for this to compile
                    print($1.value)
                    self?.configure($0)
                })
        ]
    }

    // MARK: Private API

    private func configure(_ cell: NoNewNotificationsCell) {
        switch state {
        case .loading: break
        case .success(let message): cell.configure(emoji: message.emoji, message: message.text)
        case .error: cell.configure(emoji: "🎉", message: NSLocalizedString("Inbox zero!", comment: ""))
        }
    }

    private func handleFinished(_ result: Result<NotificationEmptyMessageClient.Message>) {
        switch result {
        case .success(let message):
            state = .success(message)
        case .error(let error):
            state = .error
            let msg = error?.localizedDescription ?? ""
            Answers.logCustomEvent(withName: "fb-fetch-error", customAttributes: ["error": msg])
        }

        guard let cell = collectionContext?.cellForItem(at: 0, sectionController: self) as? NoNewNotificationsCell
            else { return }
        configure(cell)
    }

}
