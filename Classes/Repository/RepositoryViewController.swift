//
//  RepositoryViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Tabman
import Pageboy
import TUSafariActivity
import SafariServices
import Squawk
import ContextMenu

class RepositoryViewController: TabmanViewController,
PageboyViewControllerDataSource,
NewIssueTableViewControllerDelegate,
ContextMenuDelegate {

    private let repo: RepositoryDetails
    private let client: GithubClient
    private let controllers: [UIViewController]
    private var bookmarkNavController: BookmarkNavigationController? = nil
    public private(set) var branch: String

    var moreOptionsItem: UIBarButtonItem {
        let rightItem = UIBarButtonItem(image: UIImage(named: "bullets-hollow"), target: self, action: #selector(RepositoryViewController.onMore(sender:)))
        rightItem.accessibilityLabel = Constants.Strings.moreOptions
        return rightItem
    }

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
            controllers.append(RepositoryIssuesViewController(client: client, repo: repo, type: .issues))
        }
        controllers += [
            RepositoryIssuesViewController(client: client, repo: repo, type: .pullRequests),
            RepositoryCodeDirectoryViewController.createRoot(client: client, repo: repo, branch: repo.defaultBranch)
        ]
        self.controllers = controllers

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        makeBackBarItemEmpty()

        dataSource = self
        delegate = self
        bar.items = controllers.map { Item(title: $0.title ?? "" ) }
        bar.appearance = TabmanBar.Appearance({ appearance in
            appearance.text.font = Styles.Text.button.preferredFont
            appearance.state.color = Styles.Colors.Gray.light.color
            appearance.state.selectedColor = Styles.Colors.Blue.medium.color
            appearance.indicator.color = Styles.Colors.Blue.medium.color
        })

        configureNavigationItems()
        let navigationTitle = NavigationTitleDropdownView()
        navigationItem.titleView = navigationTitle
        navigationTitle.addTarget(self, action: #selector(onNavigationTitle(sender:)), for: .touchUpInside)
        let labelFormat = NSLocalizedString("Repository %@ by %@", comment: "Accessibility label for a repository navigation item")
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

    var repoUrl: URL {
        return URL(string: "https://github.com/\(repo.owner)/\(repo.name)")!
    }

    func configureNavigationItems() {
        var items = [moreOptionsItem]
        if let bookmarkItem = bookmarkNavController?.navigationItem {
            items.append(bookmarkItem)
        }
        navigationItem.rightBarButtonItems = items
    }
    
    func switchBranchAction() -> UIAlertAction {
        return UIAlertAction(
            title: NSLocalizedString("Switch Branch", comment: ""),
            style: .default
        ) {
            [weak self] action in
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

    @objc func onMore(sender: UIButton) {
        let alertTitle = "\(repo.owner)/\(repo.name):\(branch)"
        let alert = UIAlertController.configured(title: alertTitle, preferredStyle: .actionSheet)

        weak var weakSelf = self
        let alertBuilder = AlertActionBuilder { $0.rootViewController = weakSelf }

        alert.addActions([
            repo.hasIssuesEnabled ? newIssueAction() : nil,
            AlertAction(alertBuilder).share([repoUrl], activities: [TUSafariActivity()], type: .shareUrl) {
                $0.popoverPresentationController?.setSourceView(sender)
            },
            switchBranchAction(),
            AlertAction.cancel()
        ])
        alert.popoverPresentationController?.setSourceView(sender)

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: PageboyViewControllerDataSource

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return controllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return controllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    // MARK: NewIssueTableViewControllerDelegate

    func didDismissAfterCreatingIssue(model: IssueDetailsModel) {
        let issuesViewController = IssuesViewController(client: client, model: model)
        show(issuesViewController, sender: self)
    }
    
    //MARK: ContextMenuDelegate
    
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
