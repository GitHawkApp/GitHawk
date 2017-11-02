//
//  BookmarksViewController.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SwipeCellKit

class BookmarksViewController: UITableViewController,
    UISearchResultsUpdating,
    PrimaryViewController,
    SwipeTableViewCellDelegate,
    TabNavRootViewControllerType,
BookmarksStoreListener {

    private let client: GithubClient
    private var searchController: UISearchController = UISearchController(searchResultsController:nil)
    private var filteredBookmarks: [BookmarkModel]?

    private var isSearchActive: Bool {
        return filteredBookmarks != nil
    }
    private var isSwipeToDeleteActive: Bool = false

    // MARK: Init

    init(client: GithubClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
        self.client.bookmarksStore?.add(listener: self)
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
        reloadBookmarks()
    }

    // MARK: Private API

    func updateRightBarItem() {
        navigationItem.rightBarButtonItem?.isEnabled = client.bookmarksStore?.bookmarks.count ?? 0 > 0
    }

    @objc private func onClearAll(sender: UIBarButtonItem) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Are you sure?", comment: ""),
            message: NSLocalizedString("All of your bookmarks will be lost. Do you want to continue?", comment: ""),
            preferredStyle: .alert
        )

        alert.addActions([
            AlertAction.clearAll({ [weak self] _ in
                self?.client.bookmarksStore?.clear()
                self?.filteredBookmarks?.removeAll()
                self?.reloadBookmarks()
            }),
            AlertAction.cancel()
        ])

        present(alert, animated: true)
    }

    func filter(query: String?) {
        if let query = query {
            filteredBookmarks = filtered(array: client.bookmarksStore?.bookmarks ?? [], query: query)
        } else {
            filteredBookmarks = nil
        }
        reloadBookmarks()
    }

    var bookmarks: [BookmarkModel] {
        if let bookmarks = filteredBookmarks {
            return bookmarks
        } else {
            return client.bookmarksStore?.bookmarks ?? []
        }
    }

    func reloadBookmarks() {
        tableView.reloadData()
        updateRightBarItem()
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        tableView.scrollToTop(animated: true)
    }

    func didDoubleTapTab() {
        searchController.searchBar.becomeFirstResponder()
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.cellIdentifier, for: indexPath) as? BookmarkCell else {
            fatalError("Unable to dequeue the expected cell type")
        }

        let bookmark = bookmarks[indexPath.row]
        cell.configure(bookmark: bookmark)
        cell.delegate = self
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark = bookmarks[indexPath.row]
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

    // MARK: UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let term = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        filter(query: !term.isEmpty ? term : nil)
    }

    // MARK: - SwipeTableViewCellDelegate

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right, !isSearchActive else { return nil }

        let action = DeleteSwipeAction { [weak self] _, index in
            guard let strongSelf = self else { return }
            strongSelf.client.bookmarksStore?.remove(bookmark: strongSelf.bookmarks[index.row])
            strongSelf.updateRightBarItem()
        }

        return [action]
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }

    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) {
        isSwipeToDeleteActive = true
    }

    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?, for orientation: SwipeActionsOrientation) {
        isSwipeToDeleteActive = false
    }

    // MARK: - Private API

    private func configureSearchBar() {

        searchController.searchBar.placeholder = NSLocalizedString(Constants.Strings.search, comment: "")
        searchController.searchBar.tintColor = Styles.Colors.Blue.medium.color
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
       
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }

    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1.0))
        tableView.backgroundColor = Styles.Colors.background
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.cellIdentifier)
        tableView.estimatedRowHeight = Styles.Sizes.tableCellHeightLarge
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: BookmarkStoreListener

    func bookmarksDidUpdate() {
        guard !isSearchActive, !isSwipeToDeleteActive else { return }
        reloadBookmarks()
    }
}
