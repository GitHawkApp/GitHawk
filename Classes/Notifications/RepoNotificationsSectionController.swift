//
//  RepoNotificationsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCellKit

protocol RepoNotificationsSectionControllerDelegate: class {
    func didMarkRead(sectionController: RepoNotificationsSectionController)
}

final class RepoNotificationsSectionController: ListGenericSectionController<NotificationViewModel>,
SwipeCollectionViewCellDelegate {

    private let client: NotificationClient
    private weak var delegate: RepoNotificationsSectionControllerDelegate?

    init(client: NotificationClient, delegate: RepoNotificationsSectionControllerDelegate) {
        self.client = client
        self.delegate = delegate
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
        cell.bindViewModel(object)
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let object = self.object else { fatalError("Should have an object") }
        let controller = NavigateToNotificationContent(object: object, client: client.githubClient)
        viewController?.showDetailViewController(controller, sender: nil)
    }

    // MARK: SwipeCollectionViewCellDelegate

    func collectionView(
        _ collectionView: UICollectionView,
        editActionsForRowAt indexPath: IndexPath,
        for orientation: SwipeActionsOrientation
        ) -> [SwipeAction]? {
        guard orientation == .right,
            self.object?.read == false
            else { return nil }

        let title = NSLocalizedString("Read", comment: "")
        let action = SwipeAction(style: .destructive, title: title) { [weak self] (_, _) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didMarkRead(sectionController: strongSelf)
        }
        action.backgroundColor = Styles.Colors.Blue.medium.color
        action.image = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
        action.textColor = .white
        action.tintColor = .white
        action.font = Styles.Fonts.button
        action.transitionDelegate = ScaleTransition.default
        return [action]
    }

}
