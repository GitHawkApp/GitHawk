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
IssueReviewDetailsCellDelegate,
AttributedStringViewIssueDelegate {

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()
    private lazy var photoHandler: PhotoViewHandler = {
        return PhotoViewHandler(viewController: self.viewController)
    }()
    private let tailModel = "tail" as ListDiffable
    private let client: GithubClient

    init(client: GithubClient) {
        self.client = client
        super.init()
        self.inset = Styles.Sizes.listInsetLarge
        self.dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = self.object else { fatalError("Wrong model object") }
        return [object.details] + object.bodyModels + [tailModel]
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width,
            let viewModel = viewModel as? ListDiffable
            else { fatalError("Missing context") }
        // use default if IssueReviewDetailsModel
        let height: CGFloat
        if viewModel === tailModel {
            height = Styles.Sizes.rowSpacing
        } else {
            height = BodyHeightForComment(viewModel: viewModel, width: width, webviewCache: webviewCache)
        }
        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = self.collectionContext,
            let viewModel = viewModel as? ListDiffable
            else { fatalError("Missing context") }

        if viewModel === tailModel {
            return context.dequeueReusableCell(of: IssueReviewEmptyTailCell.self, for: self, at: index)
        }

        let cellClass: AnyClass
        switch viewModel {
        case is IssueReviewDetailsModel: cellClass = IssueReviewDetailsCell.self
        default: cellClass = CellTypeForComment(viewModel: viewModel)
        }
        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)

        ExtraCommentCellConfigure(
            cell: cell,
            imageDelegate: photoHandler,
            htmlDelegate: webviewCache,
            htmlNavigationDelegate: viewController,
            attributedDelegate: viewController,
            issueAttributedDelegate: self
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

    // MARK: AttributedStringViewIssueDelegate

    func didTapIssue(view: AttributedStringView, issue: IssueDetailsModel) {
        let controller = IssuesViewController(client: client, model: issue)
        viewController?.showDetailViewController(controller, sender: nil)
    }

}
