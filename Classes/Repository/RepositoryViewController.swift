//
//  RepositoryViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import TUSafariActivity
import Squawk
import ContextMenu
import DropdownTitleView

class RepositoryViewController: ButtonBarPagerTabStripViewController,
NewIssueTableViewControllerDelegate,
ContextMenuDelegate {

    private let repo: RepositoryDetails
    private let client: GithubClient
    private let controllers: [UIViewController]
    private var bookmarkNavController: BookmarkNavigationController?
    public private(set) var branch: String

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = client
        self.branch = repo.defaultBranch

        let bookmark = Bookmark(
            type: .repo,
            name: repo.name,
            owner: repo.owner,
            hasIssueEnabled: repo.hasIssuesEnabled,
            defaultBranch: repo.defaultBranch
        )
        self.bookmarkNavController = BookmarkNavigationController(store: client.bookmarksStore, model: bookmark)

        var controllers: [UIViewController] = [RepositoryOverviewViewController(client: client, repo: repo)]
        if repo.hasIssuesEnabled {
            controllers.append(RepositoryIssuesViewController(client: client, owner: repo.owner, repo: repo.name, type: .issues))
        }
        controllers += [
            RepositoryIssuesViewController(client: client, owner: repo.owner, repo: repo.name, type: .pullRequests),
            RepositoryCodeDirectoryViewController.createRoot(client: client, repo: repo, branch: repo.defaultBranch)
        ]
        self.controllers = controllers

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = Styles.Colors.Blue.medium.color
        settings.style.buttonBarItemFont = Styles.Text.body.preferredFont
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarItemTitleColor = Styles.Colors.Gray.medium.color
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarHeight = 44

        pagerBehaviour = .progressive(skipIntermediateViewControllers: true, elasticIndicatorLimit: true)
        changeCurrentIndex = { (oldCell, newCell, animated) in
            oldCell?.label.textColor = Styles.Colors.Gray.medium.color
            newCell?.label.textColor = Styles.Colors.Blue.medium.color
        }

        edgesForExtendedLayout = []

        super.viewDidLoad()

        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        makeBackBarItemEmpty()
        delegate = self

        let moreItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            target: self,
            action: #selector(RepositoryViewController.onMore(sender:))
        )
        moreItem.accessibilityLabel = Constants.Strings.moreOptions
        var items = [moreItem]
        if let bookmarkItem = bookmarkNavController?.navigationItem {
            items.append(bookmarkItem)
        }
        navigationItem.rightBarButtonItems = items

        let navigationTitle = DropdownTitleView()
        navigationItem.titleView = navigationTitle
        navigationTitle.addTarget(self, action: #selector(onNavigationTitle(sender:)), for: .touchUpInside)
        let labelFormat = NSLocalizedString(
            "Repository %@ by %@",
            comment: "Accessibility label for a repository navigation item"
        )
        let accessibilityLabel = String(format: labelFormat, arguments: [repo.name, repo.owner])
        navigationTitle.configure(title: repo.name, subtitle: repo.owner, accessibilityLabel: accessibilityLabel)
    }

    // MARK: Private API

    @objc func onNavigationTitle(sender: UIView) {
        let alert = UIAlertController.configured(preferredStyle: .actionSheet)
        weak var weakSelf = self
        alert.addActions([
            AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf })
                .view(owner: repo.owner, icon: #imageLiteral(resourceName: "organization")),
            AlertAction.cancel()
            ])
        alert.popoverPresentationController?.setSourceView(sender)
        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    var repoUrl: URL? {
        return URLBuilder.github().add(paths: [repo.owner, repo.name]).url
    }

    var switchBranchAction: UIAlertAction {
        return UIAlertAction(
            title: NSLocalizedString("Switch Branch", comment: ""),
            style: .default
        ) { [weak self] _ in
            guard let strongSelf = self else { return }
            let viewController =
                RepositoryBranchesViewController(
                    defaultBranch: strongSelf.repo.defaultBranch,
                    selectedBranch: strongSelf.branch,
                    owner: strongSelf.repo.owner,
                    repo: strongSelf.repo.name,
                    client: strongSelf.client
            )

            strongSelf.showContextualMenu(
                viewController,
                options: ContextMenu.Options(
                    containerStyle: ContextMenu.ContainerStyle(
                        backgroundColor: Styles.Colors.menuBackgroundColor.color
                    )
                ),
                delegate: self
            )
        }
    }

    func newIssueAction() -> UIAlertAction? {
        guard let newIssueViewController = NewIssueTableViewController.create(
            client: client,
            owner: repo.owner,
            repo: repo.name,
            signature: .sentWithGitHawk)
        else {
            Squawk.showGenericError()
            return nil
        }

        newIssueViewController.delegate = self
        weak var weakSelf = self

        return AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf })
            .newIssue(issueController: newIssueViewController)
    }

    func workingCopyAction() -> UIAlertAction? {
        guard let remote = repoUrl?.absoluteString
            .addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
            else { return nil}

        guard let url = URL(string: "working-copy://show?remote=\(remote)")
            else { return nil }
        guard UIApplication.shared.canOpenURL(url) else { return nil }

        let title = NSLocalizedString("Working Copy", comment: "")
        let action = UIAlertAction(title: title, style: .default,
                                   handler: { _ in
            UIApplication.shared.open(url)
        })
        return action
    }

    @objc func onMore(sender: UIButton) {
        let alertTitle = "\(repo.owner)/\(repo.name):\(branch)"
        let alert = UIAlertController.configured(title: alertTitle, preferredStyle: .actionSheet)

        weak var weakSelf = self
        let alertBuilder = AlertActionBuilder { $0.rootViewController = weakSelf }

        alert.addActions([
            viewHistoryAction(owner: repo.owner, repo: repo.name, branch: branch, client: client),
            repo.hasIssuesEnabled ? newIssueAction() : nil
        ])
        if let url = repoUrl {
            alert.add(action: AlertAction(alertBuilder).share([url], activities: [TUSafariActivity()], type: .shareUrl) {
                $0.popoverPresentationController?.setSourceView(sender)
            })
        }
        alert.addActions([
            switchBranchAction,
            workingCopyAction(),
            AlertAction.cancel()
            ])
        alert.popoverPresentationController?.setSourceView(sender)

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: ButtonBarPagerTabStripViewController Overrides

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return controllers
    }

    // MARK: NewIssueTableViewControllerDelegate

    func didDismissAfterCreatingIssue(model: IssueDetailsModel) {
        route_push(to: IssuesViewController(client: client, model: model))
    }

    // MARK: ContextMenuDelegate

    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool) {
        guard let viewController = viewController as? RepositoryBranchesViewController else { return }
        self.branch = viewController.selectedBranch
        controllers.forEach {
            if let branchUpdatable = $0 as? RepositoryBranchUpdatable {
                branchUpdatable.updateBranch(to: viewController.selectedBranch)
            }
        }
    }

    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool) {}

}
