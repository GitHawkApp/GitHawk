//
//  RepositoryViewController2.swift
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

class RepositoryViewController2: TabmanViewController, PageboyViewControllerDataSource {

    private let repo: RepositoryDetails
    private let client: GithubClient
    private let controllers: [UIViewController]

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = client
        self.controllers = [
            RepositoryOverviewViewController(client: client, repo: repo),
            RepositoryIssuesViewController(client: client, repo: repo, type: .issues),
            RepositoryIssuesViewController(client: client, repo: repo, type: .pullRequests),
        ]
        super.init(nibName: nil, bundle: nil)
        title = "\(repo.owner)/\(repo.name)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)

        automaticallyAdjustsChildScrollViewInsets = false
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
    }

    // MARK: Private API

    var repoUrl: URL {
        return URL(string: "https://github.com/\(repo.owner)/\(repo.name)")!
    }

    func shareAction(sender: UIBarButtonItem) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Send To", comment: ""), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            let safariActivity = TUSafariActivity()
            let controller = UIActivityViewController(activityItems: [strongSelf.repoUrl], applicationActivities: [safariActivity])
            controller.popoverPresentationController?.barButtonItem = sender
            strongSelf.present(controller, animated: true)
        }
    }

    func safariAction() -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Open in Safari", comment: ""), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            let controller = SFSafariViewController(url: strongSelf.repoUrl)
            strongSelf.present(controller, animated: true)
        }
    }

    func viewOwnerAction() -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("View Owner's Profile", comment: ""), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            let controller = SFSafariViewController(url: URL(string: "https://github.com/\(strongSelf.repo.owner)")!)
            strongSelf.present(controller, animated: true)
        }
    }

    func onMore(sender: UIBarButtonItem) {
        let alert = UIAlertController()
        alert.addAction(shareAction(sender: sender))
        alert.addAction(safariAction())
        alert.addAction(viewOwnerAction())
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

}
