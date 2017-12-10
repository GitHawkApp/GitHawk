//
//  IssueFilesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

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
            emptyErrorMessage: NSLocalizedString("Cannot load changes.", comment: ""),
            dataSource: self
        )
        let titleFormat = NSLocalizedString("Files (%zi)", comment: "")
        title = String.localizedStringWithFormat(titleFormat, fileCount)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        client.fetchFiles(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            page: page?.intValue ?? 1
        ) { [weak self] (result) in
                self?.handle(result: result, append: page != nil)
        }
    }

    // MARK: Private API

    func handle(result: Result<([File], Int?)>, append: Bool) {
        switch result {
        case .success(let files, let next):
            if append {
                self.files += files
            } else {
                self.files = files
            }
            update(page: next as NSNumber?, animated: trueUnlessReduceMotionEnabled)
        case .error:
            error(animated: trueUnlessReduceMotionEnabled)
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
            cell.configure(path: file.filename, additions: file.additions.intValue, deletions: file.deletions.intValue)
        }
        let size: (Any, ListCollectionContext?) -> CGSize = { (file, context) in
            guard let width = context?.containerSize.width else { fatalError("Missing context") }
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
                width: context.containerSize.width,
                height: context.containerSize.height - strongSelf.topLayoutGuide.length - strongSelf.bottomLayoutGuide.length
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
        guard let object = object as? File else { return }
        let controller = IssuePatchContentViewController(file: object, client: client)
        show(controller, sender: nil)
    }

}
