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
    private let file: String
    private let path: String
    private let repo: RepositoryDetails
    private var files = [RepositoryFile]()
    private let isRoot: Bool

    init(
        client: GithubClient,
        repo: RepositoryDetails,
        branch: String,
        path: String,
        file: String,
        isRoot: Bool
        ) {
        self.client = client
        self.repo = repo
        self.branch = branch
        self.isRoot = isRoot
        self.file = file
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
            path: "",
            file: "", 
            isRoot: true)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.configure(title: file, subtitle: path)
        makeBackBarItemEmpty()
    }

    // MARK: Private API

    var fullPath: String {
        return path.isEmpty ? file : "\(path)/\(file)"
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        client.fetchFiles(owner: repo.owner, repo: repo.name, branch: branch, path: fullPath) { [weak self] (result) in
            switch result {
            case .error:
                self?.error(animated: true)
            case .success(let files):
                self?.files = files
                self?.update(animated: true)
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
        let controller: UIViewController
        if file.isDirectory {
            controller = RepositoryCodeDirectoryViewController(
                client: client,
                repo: repo,
                branch: branch,
                path: fullPath,
                file: file.name,
                isRoot: false
            )
        } else {
            controller = RepositoryCodeBlobViewController(
                client: client,
                repo: repo,
                branch: branch,
                path: fullPath,
                filename: file.name
            )
        }
        navigationController?.pushViewController(controller, animated: true)
    }

}
