//
//  IssueFilesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import GitHubAPI

final class IssueFilesViewController: BaseListViewController<NSNumber>,
BaseListViewControllerDataSource,
ListSingleSectionControllerDelegate {

    private let model: IssueDetailsModel
    private let client: GithubClient
    private var files = [File]()
    private let feedRefresh = FeedRefresh()

    init(model: IssueDetailsModel, client: GithubClient, fileCount: Int) {
        self.model = model
        self.client = client
        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load changes.", comment: "")
        )
        self.dataSource = self
        let titleFormat = NSLocalizedString("Files (%d)", comment: "")
        title = String(format: titleFormat, fileCount)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        client.client.send(V3PullRequestFilesRequest(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            page: page?.intValue)
        ) { [weak self] result in
            switch result {
            case .success(let response):
                let files = response.data.map {
                    File(
                        status: $0.status,
                        changes: $0.changes as NSNumber,
                        filename: $0.filename,
                        additions: $0.additions as NSNumber,
                        deletions: $0.deletions as NSNumber,
                        sha: $0.sha,
                        patch: $0.patch
                    )
                }
                if page != nil {
                    self?.files += files
                } else {
                    self?.files = files
                }
                self?.update(page: response.next as NSNumber?, animated: trueUnlessReduceMotionEnabled)
            case .failure:
                self?.error(animated: trueUnlessReduceMotionEnabled)
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        return files
    }

    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController {
        let configure: (Any, UICollectionViewCell) -> Void = { (file, cell) in
            guard let file = file as? File, let cell = cell as? IssueFileCell else { return }
            cell.configure(
                path: file.filename,
                additions: file.additions.intValue,
                deletions: file.deletions.intValue,
                disclosureHidden: file.patch == nil
            )
        }
        let size: (Any, ListCollectionContext?) -> CGSize = { (file, context) in
            guard let width = context?.insetContainerSize.width else { fatalError("Missing context") }
            return CGSize(width: width, height: Styles.Sizes.tableCellHeightLarge)
        }
        let controller = ListSingleSectionController(
            cellClass: IssueFileCell.self,
            configureBlock: configure,
            sizeBlock: size
        )
        controller.selectionDelegate = self
        return controller
    }

    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController {
        let configure: (Any, UICollectionViewCell) -> Void = { (_, cell) in
            guard let cell = cell as? LabelCell else { return }
            cell.label.text = NSLocalizedString("No changes found.", comment: "")
        }
        let size: (Any, ListCollectionContext?) -> CGSize = { [weak self] (file, context) in
            guard let context = context,
                let strongSelf = self
                else { return .zero }
            return CGSize(
                width: context.insetContainerSize.width,
                height: context.insetContainerSize.height - strongSelf.view.safeAreaInsets.top - strongSelf.view.safeAreaInsets.bottom
            )
        }
        let controller = ListSingleSectionController(
            cellClass: LabelCell.self,
            configureBlock: configure,
            sizeBlock: size
        )
        return controller
    }

    // MARK: ListSingleSectionControllerDelegate

    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        guard let object = object as? File, let patch = object.patch else { return }
        let controller = IssuePatchContentViewController(patch: patch, fileName: object.actualFileName)
        show(controller, sender: nil)
    }

}
