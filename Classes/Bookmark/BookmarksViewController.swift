//
//  BookmarksViewController.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class BookmarksViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    PrimaryViewController,
TabNavRootViewControllerType {
    
    private let client: GithubClient
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let cellIdentifier = "bookmark_cell"
    private let bookmarkStore = BookmarksStore.shared

    
    // MARK: Init
    
    init(client: GithubClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Clear All", comment: ""),
            style: .plain,
            target: self,
            action: #selector(BookmarksViewController.onClearAll(sender:))
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
        tableView.reloadData()
        updateRightBarItem()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: Private API
    
    func updateRightBarItem() {
        navigationItem.rightBarButtonItem?.isEnabled = bookmarkStore.bookmarks.count > 0
    }
    
    @objc private func onClearAll(sender: UIBarButtonItem) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Bookmarks", comment: ""),
            message: NSLocalizedString("Clear all bookmarks?", comment: ""),
            preferredStyle: .alert
        )
        
        alert.addActions([
            AlertAction.clearAll({ [weak self] _ in
                self?.bookmarkStore.clear()
                self?.tableView.reloadData()
                self?.updateRightBarItem()
            }),
            AlertAction.cancel()
        ])
        
        present(alert, animated: true)
    }
    
    // MARK: TabNavRootViewControllerType
    
    func didSingleTapTab() {
        
    }
    
    func didDoubleTapTab() {
        // TODO: Scroll to top for table view
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkStore.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let bookmark = bookmarkStore.bookmarks[indexPath.row]
        let titleLabel = "\(bookmark.owner)/\(bookmark.name)"
        cell?.textLabel?.text = bookmark.type == .repo ? titleLabel : titleLabel + " #\(bookmark.number)"
        cell?.detailTextLabel?.text = bookmark.title
        cell?.textLabel?.numberOfLines = 0
        cell?.detailTextLabel?.numberOfLines = 0
        
        var imageName = ""
        switch bookmark.type {
            case .repo: imageName = "repo"
            case .issue: imageName = "issue-opened"
            case .pullRequest: imageName = "git-pull-request"
        }
    
        cell?.imageView?.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        cell?.imageView?.tintColor = Styles.Colors.Blue.medium.color
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bookmark = bookmarkStore.bookmarks[indexPath.row]
        switch bookmark.type {
        case .repo:
            let repo = RepositoryDetails(owner: bookmark.owner, name: bookmark.name, hasIssuesEnabled: bookmark.hasIssueEnabled)
            let repoViewController = RepositoryViewController(client: client, repo: repo)
            let navigation = UINavigationController(rootViewController: repoViewController)
            showDetailViewController(navigation, sender: nil)

        case .issue, .pullRequest:
            let issueModel = IssueDetailsModel(owner: bookmark.owner, repo: bookmark.name, number: bookmark.number)
            let controller = IssuesViewController(client: client, model: issueModel)
            let navigation = UINavigationController(rootViewController: controller)
            showDetailViewController(navigation, sender: nil)
        }
    }
}
