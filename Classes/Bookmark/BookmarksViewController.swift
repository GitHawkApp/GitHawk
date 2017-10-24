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
    UISearchBarDelegate,
    PrimaryViewController,
    SwipeTableViewCellDelegate,
TabNavRootViewControllerType {

    private let client: GithubClient
    private let cellIdentifier = "bookmark_cell"
    private let bookmarkStore = BookmarksStore.shared

    private var searchController: UISearchController {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.delegate = self
        controller.searchBar.placeholder = NSLocalizedString(Constants.Strings.search, comment: "")
        controller.searchBar.tintColor = Styles.Colors.Blue.medium.color
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.searchBarStyle = .minimal
        return controller
    private var filteredBookmarks: [BookmarkModel]?

    private var isSearchActive: Bool {
        return filteredBookmarks != nil
    }

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
                self?.filteredBookmarks?.removeAll()
                self?.tableView.reloadData()
                self?.updateRightBarItem()
            }),
            AlertAction.cancel()
        ])

        present(alert, animated: true)
    }

    func filter(query: String?) {
        if let query = query {
            filteredBookmarks = filtered(array: bookmarkStore.bookmarks, query: query)
        } else {
            filteredBookmarks = nil
        }
        self.tableView.reloadData()
    }

    var bookmarks: [BookmarkModel] {
        if let bookmarks = filteredBookmarks {
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
        searchController.searchBar.becomeFirstResponder()
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SwipeSelectableTableCell else {
            fatalError("Unable to dequeue the expected cell type")
        }

        let bookmark = bookmarks[indexPath.row]
        configure(cell: cell, with: bookmark)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Styles.Sizes.tableCellHeightLarge
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

    // MARK: - SwipeTableViewCellDelegate

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right, !isSearchActive else { return nil }

        let action = DeleteSwipeAction { [weak self] _, index in
            guard let strongSelf = self else { return }
            strongSelf.bookmarkStore.remove(bookmark: strongSelf.bookmarks[index.row])
            strongSelf.updateRightBarItem()
        }

        return [action]
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }

    // MARK: - Private API

    private func configureSearchBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }

    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1.0))
        tableView.backgroundColor = Styles.Colors.background
        tableView.register(SwipeSelectableTableCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    private func configure(cell: SwipeSelectableTableCell, with bookmark: BookmarkModel) {
        let titleLabel = "\(bookmark.owner)/\(bookmark.name)"
        cell.textLabel?.text = bookmark.type == .repo ? titleLabel : titleLabel + " #\(bookmark.number)"
        cell.detailTextLabel?.text = bookmark.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.accessibilityTraits |= UIAccessibilityTraitButton
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = cell.contentView.subviews
            .flatMap { $0.accessibilityLabel }
            .reduce("", { $0 + ".\n" + $1 })

        cell.imageView?.image = bookmark.type.icon?.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = Styles.Colors.Blue.medium.color

        cell.delegate = self
    }
}
