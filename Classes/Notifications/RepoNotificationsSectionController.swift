//
//  RepoNotificationsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class RepoNotificationsSectionController: ListGenericSectionController<NotificationViewModel> {

    let client: GithubClient

    init(client: GithubClient) {
        self.client = client
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
        cell.bindViewModel(object)
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let object = self.object else { return }
        let controller = IssuesViewController(
            client: client,
            owner: object.owner,
            repo: object.repo,
            number: object.number
        )
        viewController?.showDetailViewController(controller, sender: nil)
    }

}

