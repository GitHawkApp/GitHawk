//
//  BookmarksViewController.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class BookmarksViewController: UITableViewController,
    UISearchBarDelegate,
    PrimaryViewController,
TabNavRootViewControllerType {

    private let client: GithubClient
    private let cellIdentifier = "bookmark_cell"
    private let bookmarkStore = BookmarksStore.shared
    private let searchBar = UISearchBar()
    private var filterdBookmarks: [BookmarkModel]?

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

        configureSearchBar()
        configureTableView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString(Constants.Strings.clearAll, comment: ""),
            style: .plain,
            target: self,
            action: #selector(BookmarksViewController.onClearAll(sender:))
        )
        
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.cellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
        tableView.reloadData()
        updateRightBarItem()
    }

    // MARK: Private API

    func updateRightBarItem() {
        navigationItem.rightBarButtonItem?.isEnabled = bookmarkStore.bookmarks.count > 0
    }

    @objc private func onClearAll(sender: UIBarButtonItem) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Are you sure?", comment: ""),
            message: NSLocalizedString("All of your bookmarks will be lost. Do you want to continue?", comment: ""),
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

    func filter(query: String?) {
        if let query = query {
            filterdBookmarks = filtered(array: bookmarkStore.bookmarks, query: query)
        } else {
            filterdBookmarks = nil
        }
        self.tableView.reloadData()
    }

    func getBookmarks() -> [BookmarkModel] {
        if let bookmarks = filterdBookmarks {
            return bookmarks
        } else {
            return bookmarkStore.bookmarks
        }
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        tableView.scrollToTop(animated: true)
    }

    func didDoubleTapTab() {
        searchBar.becomeFirstResponder()
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getBookmarks().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.cellIdentifier, for: indexPath) as? BookmarkCell
        else { fatalError("Wrong cell type") }
    
        let bookmark = getBookmarks()[indexPath.row]
        cell.configure(bookmark: bookmark)
    
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return filterdBookmarks != nil ? false : true // avoid swipe to delete when search bar is active
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        bookmarkStore.remove(bookmark: getBookmarks()[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark = getBookmarks()[indexPath.row]
        let destinationViewController: UIViewController

        switch bookmark.type {
        case .repo:
            let repo = RepositoryDetails(
                owner: bookmark.owner,
                name: bookmark.name,
                hasIssuesEnabled: bookmark.hasIssueEnabled
            )
            destinationViewController = RepositoryViewController(client: client, repo: repo)

        case .issue, .pullRequest:
            let issueModel = IssueDetailsModel(
                owner: bookmark.owner,
                repo: bookmark.name,
                number: bookmark.number
            )
            destinationViewController = IssuesViewController(client: client, model: issueModel)
        default:
            return
        }
        let navigation = UINavigationController(rootViewController: destinationViewController)
        showDetailViewController(navigation, sender: nil)
    }

    // MARK: UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let term = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        filter(query: term)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let term = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !term.isEmpty else { return }

        filter(query: term)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filter(query: nil)
    }

    // MARK: - Private API

    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "\(Constants.Strings.search) \(Constants.Strings.bookmarks)" // Localization is done in the constants.
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
    }

    private func configureTableView() {
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1.0))
        tableView.backgroundColor = Styles.Colors.background
    }
}
