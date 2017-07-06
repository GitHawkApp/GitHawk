//
//  IssueReviewSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueReviewSectionController: ListBindingSectionController<IssueReviewModel>,
    ListBindingSectionControllerDataSource,
IssueReviewDetailsCellDelegate {

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()
    private lazy var photoHandler: PhotoViewHandler = {
        return PhotoViewHandler(viewController: self.viewController)
    }()

    override init() {
        super.init()
        self.inset = Styles.Sizes.listInsetLargeHead
        self.dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = self.object else { fatalError("Wrong model object") }
        return [object.details] + object.bodyModels
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        let height = BodyHeightForComment(viewModel: viewModel, width: width, webviewCache: webviewCache)
        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = self.collectionContext else { fatalError("Missing context") }
        let cellClass: AnyClass = CellTypeForComment(viewModel: viewModel)
        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)

        ExtraCommentCellConfigure(
            cell: cell,
            imageDelegate: photoHandler,
            htmlDelegate: webviewCache,
            htmlNavigationDelegate: viewController,
            attributedDelegate: viewController
        )

        if let cell = cell as? IssueReviewDetailsCell {
            cell.delegate = self
        }

        return cell
    }

    // MARK: IssueReviewDetailsCellDelegate

    func didTapActor(cell: IssueReviewDetailsCell) {
        guard let actor = object?.details.actor else { return }
        viewController?.presentProfile(login: actor)
    }

}
