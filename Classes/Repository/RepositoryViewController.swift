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

class RepositoryViewController: TabmanViewController,
PageboyViewControllerDataSource,
NewIssueTableViewControllerDelegate {

    private let repo: RepositoryDetails
    private let client: GithubClient
    private let controllers: [UIViewController]

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = client

        var controllers: [UIViewController] = [RepositoryOverviewViewController(client: client, repo: repo)]
        if repo.hasIssuesEnabled {
            controllers.append(RepositoryIssuesViewController(client: client, repo: repo, type: .issues))
        }
        controllers += [
            RepositoryIssuesViewController(client: client, repo: repo, type: .pullRequests),
            RepositoryCodeDirectoryViewController(client: client, repo: repo, path: "", isRoot: true)
        ]
        self.controllers = controllers

        super.init(nibName: nil, bundle: nil)

        self.title = "\(repo.owner)/\(repo.name)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeBackBarItemEmpty()

        dataSource = self
        bar.items = controllers.map { Item(title: $0.title ?? "" ) }
        bar.appearance = TabmanBar.Appearance({ appearance in
            appearance.text.font = Styles.Fonts.button
            appearance.state.color = Styles.Colors.Gray.light.color
            appearance.state.selectedColor = Styles.Colors.Blue.medium.color
            appearance.indicator.color = Styles.Colors.Blue.medium.color
        })

        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        rightItem.accessibilityLabel = NSLocalizedString("More options", comment: "")
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.configure(title: repo.name, subtitle: repo.owner)
    }

    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        } else {
            // Fallback on earlier versions
        }
        setNeedsScrollViewInsetUpdate()
        print("safe area insets changed")
    }

    // MARK: Private API

    var repoUrl: URL {
        return URL(string: "https://github.com/\(repo.owner)/\(repo.name)")!
    }

    func newIssueAction() -> UIAlertAction? {
        guard let newIssueViewController = NewIssueTableViewController.create(
            client: client,
            owner: repo.owner,
            repo: repo.name,
            signature: .sentWithGitHawk)
        else {
            ToastManager.showGenericError()
            return nil
        }

        newIssueViewController.delegate = self
        weak var weakSelf = self

        return AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf })
            .newIssue(issueController: newIssueViewController)
    }

    func bookmarkAction() -> UIAlertAction? {
        guard let store = client.bookmarksStore else { return nil }
        let bookmarkModel = BookmarkModel(
            type: .repo,
            name: repo.name,
            owner: repo.owner,
            hasIssueEnabled: repo.hasIssuesEnabled
        )
        return AlertAction.toggleBookmark(store: store, model: bookmarkModel)
    }

    @objc
    func onMore(sender: UIBarButtonItem) {
        let alert = UIAlertController.configured(preferredStyle: .actionSheet)

        weak var weakSelf = self
        let alertBuilder = AlertActionBuilder { $0.rootViewController = weakSelf }

        alert.addActions([
            repo.hasIssuesEnabled ? newIssueAction() : nil,
            AlertAction(alertBuilder).share([repoUrl], activities: [TUSafariActivity()]) { $0.popoverPresentationController?.barButtonItem = sender },
            AlertAction(alertBuilder).view(owner: repo.owner, url: repo.ownerURL),
            bookmarkAction(),
            AlertAction.cancel()
        ])
        alert.popoverPresentationController?.barButtonItem = sender

        present(alert, animated: true)
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

}
