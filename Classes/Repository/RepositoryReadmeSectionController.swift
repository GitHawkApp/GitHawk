//
//  RepositoryReadmeSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class RepositoryReadmeSectionController: ListBindingSectionController<RepositoryReadmeModel>,
ListBindingSectionControllerDataSource {

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()
    private lazy var imageCache: ImageCellHeightCache = {
        return ImageCellHeightCache(sectionController: self)
    }()
    private lazy var photoHandler: PhotoViewHandler = {
        return PhotoViewHandler(viewController: self.viewController)
    }()

    override init() {
        super.init()
        dataSource = self
        inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)
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
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Missing context") }
        let insetWidth = width - inset.left - inset.right
        let height = BodyHeightForComment(
            viewModel: viewModel,
            width: insetWidth,
            webviewCache: webviewCache,
            imageCache: imageCache
        )
        return CGSize(width: insetWidth, height: height)
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
            imageDelegate: photoHandler,
            htmlDelegate: webviewCache,
            htmlNavigationDelegate: viewController,
            htmlImageDelegate: photoHandler,
            markdownDelegate: viewController,
            imageHeightDelegate: imageCache
        )

        return cell
    }

}
