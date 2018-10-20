//
//  RepositoryCodeDirectoryViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import TUSafariActivity

final class RepositoryCodeDirectoryViewController: BaseListViewController<NSNumber>,
BaseListViewControllerDataSource,
ListSingleSectionControllerDelegate,
RepositoryBranchUpdatable {

    private let client: GithubClient
    private var branch: String
    private let path: FilePath
    private let repo: RepositoryDetails
    private var files = [RepositoryFile]()
    private var repoUrl: URL {
        return URL(string: "https://github.com/\(repo.owner)/\(repo.name)/tree/\(branch)/\(path.path)")!
    }
    private lazy var moreOptionsItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            target: self,
            action: #selector(RepositoryCodeDirectoryViewController.onShare(sender:)))
        barButtonItem.isEnabled = false

        return barButtonItem
    }()

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
            emptyErrorMessage: NSLocalizedString("Cannot load directory.", comment: "")
        )

        self.dataSource = self

        // set on init in case used by Tabman
        self.title = NSLocalizedString("Code", comment: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle(filePath: path, target: self, action: #selector(onFileNavigationTitle(sender:)))
        makeBackBarItemEmpty()
        navigationItem.rightBarButtonItem = moreOptionsItem
    }

    // MARK: Public API

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

    // MARK: Private API

    @objc func onFileNavigationTitle(sender: UIView) {
        showAlert(filePath: path, sender: sender)
    }

    @objc func onShare(sender: UIButton) {
        let alertTitle = "\(repo.owner)/\(repo.name):\(branch)"
        let alert = UIAlertController.configured(title: alertTitle, preferredStyle: .actionSheet)

        weak var weakSelf = self
        let alertBuilder = AlertActionBuilder { $0.rootViewController = weakSelf }
        var actions = [
            viewHistoryAction(owner: repo.owner, repo: repo.name, branch: branch, client: client, path: path),
            AlertAction(alertBuilder).share([path.path], activities: nil, type: .shareFilePath) {
                $0.popoverPresentationController?.setSourceView(sender)
            },
            AlertAction(alertBuilder).share([repoUrl], activities: [TUSafariActivity()], type: .shareUrl) {
                $0.popoverPresentationController?.setSourceView(sender)
            },
            AlertAction.cancel()
        ]

        if let name = self.path.components.last {
            actions.insert(AlertAction(alertBuilder).share([name], activities: nil, type: .shareFileName) {
                $0.popoverPresentationController?.setSourceView(sender)
            }, at: 1)
        }

        alert.addActions(actions)
        alert.popoverPresentationController?.setSourceView(sender)
        present(alert, animated: trueUnlessReduceMotionEnabled)
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
                self?.moreOptionsItem.isEnabled = true
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
                height: context.containerSize.height - strongSelf.view.safeAreaInsets.top - strongSelf.view.safeAreaInsets.bottom
            )
        })
    }

    // MARK: ListSingleSectionControllerDelegate

    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        guard let file = object as? RepositoryFile else { return }
        let nextPath = path.appending(file.name)

        if file.isDirectory {
            showDirectory(at: nextPath)
        } else {
            showFile(at: nextPath)
        }
    }

}

// MARK: - RepositoryCodeDirectoryViewController (Navigation) -

extension RepositoryCodeDirectoryViewController {

    private func showDirectory(at path: FilePath) {
        let controller = RepositoryCodeDirectoryViewController(
            client: client,
            repo: repo,
            branch: branch,
            path: path
        )

        navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

    private func showFile(at path: FilePath) {
        let controller: UIViewController

        if path.hasBinarySuffix {
            controller = RepositoryWebViewController(
                repo: repo,
                branch: branch,
                path: path
            )
        } else {
            controller = RepositoryCodeBlobViewController(
                client: client,
                repo: repo,
                branch: branch,
                path: path
            )
        }

        navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: RepositoryBranchUpdatable

    func updateBranch(to newBranch: String) {
        guard self.branch != newBranch else { return }
        self.branch = newBranch
        fetch(page: nil)
    }

}
