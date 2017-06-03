//
//  RepoNotificationsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class RepoNotificationsSectionController: IGListGenericSectionController<NotificationViewModel> {

    let client: GithubClient

    init(client: GithubClient) {
        self.client = client
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext,
            let object = self.object
            else { return .zero }
        return CGSize(width: context.containerSize.width, height: object.titleSize.height)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let object = self.object,
            let cell = context.dequeueReusableCell(of: NotificationCell.self, for: self, at: index) as? NotificationCell
            else { return UICollectionViewCell() }
        cell.bindViewModel(object)
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let object = self.object else { return }
        let controller = IssuesViewController(
            client: client,
            owner: object.owner,
            repo: object.repo,
            number: object.number,
            pullRequest: object.type == .pullRequest
        )
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }

}
