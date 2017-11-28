//
//  IssuePreviewViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssuePreviewSectionController: ListBindingSectionController<IssuePreviewModel>,
ListBindingSectionControllerDataSource {

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()
    private lazy var imageCache: ImageCellHeightCache = {
        return ImageCellHeightCache(sectionController: self)
    }()

    override init() {
        super.init()
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        return self.object?.models ?? []
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        let height = BodyHeightForComment(
            viewModel: viewModel,
            width: width,
            webviewCache: webviewCache,
            imageCache: imageCache
        )
        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        guard let context = self.collectionContext else { fatalError("Missing context") }

        let cellClass: AnyClass = CellTypeForComment(viewModel: viewModel)
        guard let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError("Cell not bindable") }

        ExtraCommentCellConfigure(
            cell: cell,
            imageDelegate: nil,
            htmlDelegate: webviewCache,
            htmlNavigationDelegate: nil,
            htmlImageDelegate: nil,
            attributedDelegate: nil,
            issueAttributedDelegate: nil,
            imageHeightDelegate: imageCache
        )

        return cell
    }

}
