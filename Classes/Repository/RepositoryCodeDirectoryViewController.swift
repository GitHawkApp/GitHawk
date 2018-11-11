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
import Squawk
import XLPagerTabStrip

final class RepositoryCodeDirectoryViewController: BaseListViewController<Int>,
    BaseListViewControllerDataSource,
    BaseListViewControllerEmptyDataSource,
    RepositoryCodeDirectorySectionControllerDelegate,
    RepositoryBranchUpdatable,
IndicatorInfoProvider {

    private let client: GithubClient
    private var branch: String
    private let path: FilePath
    private let repo: RepositoryDetails
    private var files = [RepositoryFile]()
    private var repoUrl: URL? {
        return URLBuilder.github()
            .add(paths: [repo.owner, repo.name, "tree", branch])
            .add(paths: path.components)
            .url
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
        self.emptyDataSource = self

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

        let alertBuilder = AlertActionBuilder { [weak self] in $0.rootViewController = self }
        var actions = [
            viewHistoryAction(owner: repo.owner, repo: repo.name, branch: branch, client: client, path: path),
            AlertAction(alertBuilder).share([path.path], activities: nil, type: .shareFilePath) {
                $0.popoverPresentationController?.setSourceView(sender)
            }
        ]

        if let url = repoUrl {
            actions.append(AlertAction(alertBuilder).share([url], activities: [TUSafariActivity()], type: .shareUrl) {
                $0.popoverPresentationController?.setSourceView(sender)
            })
        }
        actions.append(AlertAction.cancel())

        if let name = self.path.components.last {
            actions.insert(AlertAction(alertBuilder).share([name], activities: nil, type: .shareFileName) {
                $0.popoverPresentationController?.setSourceView(sender)
            }, at: 1)
        }

        alert.addActions(actions)
        alert.popoverPresentationController?.setSourceView(sender)
        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

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

    // MARK: Overrides

    override func fetch(page: Int?) {
        client.fetchFiles(
        owner: repo.owner,
        repo: repo.name,
        branch: branch,
        path: path.path
        ) { [weak self] (result) in
            switch result {
            case .error(let error):
                Squawk.show(error: error)
                self?.error(animated: trueUnlessReduceMotionEnabled)
            case .success(let files):
                self?.files = files
                self?.update(animated: trueUnlessReduceMotionEnabled)
                self?.moreOptionsItem.isEnabled = true
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return files.map {
            ListSwiftPair.pair($0, { [weak self] in RepositoryCodeDirectorySectionController(delegate: self) })
        }
    }

    // MARK: BaseListViewControllerEmptyDataSource

    func emptyModel(for adapter: ListSwiftAdapter) -> ListSwiftPair {
        return ListSwiftPair.pair(NSLocalizedString("No files found.", comment: ""), {
            EmptyMessageSectionController()
        })
    }

    // MARK: RepositoryCodeDirectorySectionControllerDelegate

    func didSelect(controller: RepositoryCodeDirectorySectionController, path: String, isDirectory: Bool) {
        let nextPath = self.path.appending(path)
        if isDirectory {
            showDirectory(at: nextPath)
        } else {
            showFile(at: nextPath)
        }
    }

    // MARK: RepositoryBranchUpdatable

    func updateBranch(to newBranch: String) {
        guard self.branch != newBranch else { return }
        self.branch = newBranch
        fetch(page: nil)
    }

    // MARK: IndicatorInfoProvider

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: title)
    }

}
