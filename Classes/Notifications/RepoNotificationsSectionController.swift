//
//  RepoNotificationsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class RepoNotificationsSectionController: IGListBindingSectionController<RepoNotifications>, IGListBindingSectionControllerDataSource {

    var expanded = true

    override init() {
        super.init()
        dataSource = self
        inset = UIEdgeInsets(top: 0, left: 0, bottom: Styles.Sizes.cellSpacing, right: 0)
        minimumLineSpacing = Styles.Sizes.rowSpacing
    }

    // MARK: IGListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        viewModelsFor object: Any
        ) -> [IGListDiffable] {
        guard let object = self.object else { return [] }
        return [object.repoName as IGListDiffable] + object.notifications
    }

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = collectionContext else { return UICollectionViewCell() }
        if viewModel is String {
            return context.dequeueReusableCell(of: NotificationRepoCell.self, for: self, at: index)
        } else {
            return context.dequeueReusableCell(of: NotificationCell.self, for: self, at: index)
        }
    }

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let context = collectionContext else { return .zero }
        let height: CGFloat
        if let viewModel = viewModel as? NotificationViewModel {
            height = viewModel.titleSize.height
        } else {
            height = 30
        }
        return CGSize(width: context.containerSize.width, height: height)
    }

}
