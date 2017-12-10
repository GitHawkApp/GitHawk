//
//  RepositoryCodeDirectoryViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class RepositoryCodeDirectoryViewController: BaseListViewController<NSNumber>,
BaseListViewControllerDataSource,
ListSingleSectionControllerDelegate {

    private let client: GithubClient
    private let branch: String
    private let path: FilePath
    private let repo: RepositoryDetails
    private var files = [RepositoryFile]()

    init(
        client: GithubClient,
        repo: RepositoryDetails,
        branch: String,
        path: FilePath
        ) {
        self.client = client
        self.repo = repo
        self.branch = branch
        self.path = path

        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load issues.", comment: ""),
            dataSource: self
        )

        // set on init in case used by Tabman
        self.title = NSLocalizedString("Code", comment: "")
    }

    static func createRoot(
        client: GithubClient,
        repo: RepositoryDetails,
        branch: String
        ) -> RepositoryCodeDirectoryViewController {
        return RepositoryCodeDirectoryViewController(
            client: client,
            repo: repo,
            branch: branch,
            path: FilePath(components: [])
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.configure(filePath: path)
        makeBackBarItemEmpty()
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        client.fetchFiles(
        owner: repo.owner,
        repo: repo.name,
        branch: branch,
        path: path.path
        ) { [weak self] (result) in
            switch result {
            case .error:
                self?.error(animated: trueUnlessReduceMotionEnabled)
            case .success(let files):
                self?.files = files
                self?.update(animated: trueUnlessReduceMotionEnabled)
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
        let controller = ListSingleSectionController(cellClass: RepositoryFileCell.self, configureBlock: { (file, cell: UICollectionViewCell) in
            guard let cell = cell as? RepositoryFileCell, let file = file as? RepositoryFile else { return }
            cell.configure(path: file.name, isDirectory: file.isDirectory)
        }, sizeBlock: { (_, context: ListCollectionContext?) -> CGSize in
            guard let width = context?.containerSize.width else { return .zero }
            return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
        })
        controller.selectionDelegate = self
        return controller
    }

    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController {
        return ListSingleSectionController(cellClass: LabelCell.self, configureBlock: { (_, cell: UICollectionViewCell) in
            guard let cell = cell as? LabelCell else { return }
            cell.label.text = NSLocalizedString("No files found.", comment: "")
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

    // MARK: ListSingleSectionControllerDelegate

    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        guard let file = object as? RepositoryFile else { return }
        let next = path.appending(file.name)
        let controller: UIViewController
        if file.isDirectory {
            controller = RepositoryCodeDirectoryViewController(
                client: client,
                repo: repo,
                branch: branch,
                path: next
            )
        } else {
            controller = RepositoryCodeBlobViewController(
                client: client,
                repo: repo,
                branch: branch,
                path: next
            )
        }
        navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

}
