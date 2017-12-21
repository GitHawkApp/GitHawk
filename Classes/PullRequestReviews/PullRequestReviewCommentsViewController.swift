//
//  PullRequestReviewCommentsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class PullRequestReviewCommentsViewController: BaseListViewController<NSNumber>,
BaseListViewControllerDataSource {

    private let model: IssueDetailsModel
    private let client: GithubClient
    private var models = [ListDiffable]()

    init(model: IssueDetailsModel, client: GithubClient) {
        self.model = model
        self.client = client
        super.init(
            emptyErrorMessage: NSLocalizedString("Error loading review comments.", comment: ""),
            dataSource: self
        )
        title = NSLocalizedString("Review Comments", comment: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        client.fetchPRComments(
        owner: model.owner,
        repo: model.repo,
        number: model.number,
        width: view.bounds.width
        ) { [weak self] (result) in
            switch result {
            case .error: ToastManager.showGenericError()
            case .success(let models, let page):
                self?.models = models
                self?.update(page: page as NSNumber?, animated: trueUnlessReduceMotionEnabled)
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        return models
    }

    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController {
        switch model {
        case is NSAttributedStringSizing: return IssueTitleSectionController()
        case is IssueCommentModel: return IssueCommentSectionController(model: self.model, client: client)
        case is IssueDiffHunkModel: return IssueDiffHunkSectionController()
        default: fatalError("Unhandled object: \(model)")
        }
    }

    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController {
        return ListSingleSectionController(cellClass: LabelCell.self, configureBlock: { (_, cell: UICollectionViewCell) in
            guard let cell = cell as? LabelCell else { return }
            cell.label.text = NSLocalizedString("No review comments found.", comment: "")
        }, sizeBlock: { [weak self] (_, context: ListCollectionContext?) -> CGSize in
            guard let context = context,
            let strongSelf = self
                else { return .zero }
            return CGSize(
                width: context.containerSize.width,
                height: context.containerSize.height - strongSelf.topLayoutGuide.length - strongSelf.bottomLayoutGuide.length
            )
        })
    }

    // MARK: IssueCommentSectionControllerDelegate

}
