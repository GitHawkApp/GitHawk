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
    private var message: NotificationEmptyMessageClient.Message?

    init(topInset: CGFloat, topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        self.topInset = topInset
        self.topLayoutGuide = topLayoutGuide
        self.bottomLayoutGuide = bottomLayoutGuide
        super.init()
        client.fetch { [weak self] (result) in
            switch result {
            case .success(let message):
                self?.handle(message)
            case .error(let error):
                let msg = error?.localizedDescription ?? ""
                Answers.logCustomEvent(withName: "fb-fetch-error", customAttributes: ["error": msg])
            }
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
        if let message = self.message {
            cell.configure(emoji: message.emoji, message: message.text)
        }
        return cell
    }

    // MARK: Private API

    private func handle(_ message: NotificationEmptyMessageClient.Message) {
        self.message = message
        let cell = collectionContext?.cellForItem(at: 0, sectionController: self) as? NoNewNotificationsCell
        cell?.configure(emoji: message.emoji, message: message.text)
    }

}
