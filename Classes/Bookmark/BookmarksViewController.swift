//
//  BookmarksViewController.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class BookmarksViewController:
    UITableViewController,
    UISearchBarDelegate,
    PrimaryViewController,
TabNavRootViewControllerType {
  
    private let client: GithubClient
    private let cellIdentifier = "bookmark_cell"
    private let bookmarkStore = BookmarksStore.shared
    private let searchBar = UISearchBar()
    private var filterdBookmarks: [BookmarkModel]? = nil
    private var searchController: UISearchController {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.delegate = self
        controller.searchBar.placeholder = NSLocalizedString(Constants.Strings.search, comment: "")
        controller.searchBar.tintColor = Styles.Colors.Blue.medium.color
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.searchBarStyle = .minimal
        return controller
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
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
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
        }
        else {
            filterdBookmarks = nil
        }
        self.tableView.reloadData()
    }
    
    func getBookmarks() -> [BookmarkModel] {
        if let bookmarks = filterdBookmarks {
            return bookmarks
        }
        else {
            return bookmarkStore.bookmarks
        }
    }
    
    // MARK: TabNavRootViewControllerType
    
    func didSingleTapTab() {
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func didDoubleTapTab() {
        searchBar.becomeFirstResponder()
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getBookmarks().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let bookmark = getBookmarks()[indexPath.row]
        
        let titleLabel = "\(bookmark.owner)/\(bookmark.name)"
        cell?.textLabel?.text = bookmark.type == .repo ? titleLabel : titleLabel + " #\(bookmark.number)"
        cell?.detailTextLabel?.text = bookmark.title
        cell?.textLabel?.numberOfLines = 0
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.accessibilityTraits |= UIAccessibilityTraitButton
        cell?.isAccessibilityElement = true
        cell?.accessibilityLabel = cell?.contentView.subviews
            .flatMap { $0.accessibilityLabel }
            .reduce("", { $0 + ".\n" + $1 })

        cell?.imageView?.image = bookmark.type.icon?.withRenderingMode(.alwaysTemplate)
        cell?.imageView?.tintColor = Styles.Colors.Blue.medium.color
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return filterdBookmarks != nil ? false : true // avoid swipe to delete when search bar is active
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            bookmarkStore.remove(bookmark: getBookmarks()[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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
}
