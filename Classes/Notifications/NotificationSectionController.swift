//
//  NotificationSectionControllerDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCellKit

final class NotificationSectionController: ListGenericSectionController<NotificationViewModel>,
SwipeCollectionViewCellDelegate {

    private let client: NotificationClient
    private let dataSource: NotificationsDataSource

    init(client: NotificationClient, dataSource: NotificationsDataSource) {
        self.client = client
        self.dataSource = dataSource
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: object?.title.textViewSize(width).height ?? 0)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let object = self.object,
            let cell = collectionContext?.dequeueReusableCell(of: NotificationCell.self, for: self, at: index) as? NotificationCell
            else { fatalError("Collection context must be set, missing object, or cell incorrect type") }

        cell.delegate = self
        cell.configure(object)
        cell.isRead = considerObjectRead

        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let object = self.object,
            let cell = collectionContext?.cellForItem(at: index, sectionController: self) as? NotificationCell
            else { fatalError("Missing object, cell missing, or incorrect type") }

        if NotificationClient.readOnOpen() {
            cell.isRead = true
            client.markNotificationRead(id: object.id, isOpen: true)
        }

        let controller = NavigateToNotificationContent(object: object, client: client.githubClient)
        viewController?.showDetailViewController(controller, sender: nil)
    }

    // MARK: Private API

    func markRead() {
        guard let object = object else { fatalError("Should have an object") }
        client.markNotificationRead(id: object.id, isOpen: false)
        collectionContext?.performBatch(animated: true, updates: { context in
            context.reload(self)
        })
    }

    var considerObjectRead: Bool {
        guard let object = object else { fatalError("Should have an object") }
        return dataSource.isRead(notification: object)
    }

    // MARK: SwipeCollectionViewCellDelegate

    func collectionView(
        _ collectionView: UICollectionView,
        editActionsForRowAt indexPath: IndexPath,
        for orientation: SwipeActionsOrientation
        ) -> [SwipeAction]? {
        guard orientation == .right, !considerObjectRead else { return nil }

        let title = NSLocalizedString("Read", comment: "")
        let action = SwipeAction(style: .destructive, title: title) { [weak self] (action, _) in
            self?.markRead()
        }

        action.backgroundColor = Styles.Colors.Blue.medium.color
        action.image = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
        action.textColor = .white
        action.tintColor = .white
        action.font = Styles.Fonts.button
        action.transitionDelegate = ScaleTransition.default
        return [action]
    }

    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .selection
        return options
    }

}
