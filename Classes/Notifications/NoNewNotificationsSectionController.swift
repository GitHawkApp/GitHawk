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

final class NoNewNotificationSectionController: ListSectionController {

    private let topInset: CGFloat
    private let topLayoutGuide: UILayoutSupport
    private let bottomLayoutGuide: UILayoutSupport
    private let client = NotificationEmptyMessageClient()

    enum State {
        case loading
        case success(NotificationEmptyMessageClient.Message)
        case error
    }
    private var state: State = .loading

    init(topInset: CGFloat, topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        self.topInset = topInset
        self.topLayoutGuide = topLayoutGuide
        self.bottomLayoutGuide = bottomLayoutGuide
        super.init()
        client.fetch { [weak self] (result) in
            self?.handleFinished(result)
        }
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize
            else { fatalError("Missing context") }
        return CGSize(width: size.width, height: size.height - topInset - topLayoutGuide.length - bottomLayoutGuide.length)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: NoNewNotificationsCell.self, for: self, at: index) as? NoNewNotificationsCell
            else { fatalError("Missing context or cell is wrong type") }
        configure(cell)
        return cell
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
