//
//  BookmarkViewController.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import Apollo

class BookmarkViewController: UIViewController,
    ListAdapterDataSource,
    PrimaryViewController,
    UISearchBarDelegate,
BookmarkHeaderSectionControllerDelegate,
StoreListener,
BookmarkSectionControllerDelegate,
InitialEmptyViewDelegate,
TabNavRootViewControllerType {

    private let client: GithubClient
    private let headerKey = "com.freetime.BookmarkViewController.bookmark-header-key" as ListDiffable

    private let searchBar = UISearchBar()
    private lazy var adapter: ListAdapter = { ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout.basic())
        view.alwaysBounceVertical = true
        view.backgroundColor = Styles.Colors.background
        return view
    }()
    private var keyboardAdjuster: ScrollViewKeyboardAdjuster?

    var bookmarkStore: BookmarkStore

    enum State {
        case idle
        case filtering(String)
    }

    var state: State = .idle

    // MARK: Initialization

    init(client: GithubClient) {
        self.client = client
        guard let store = client.bookmarksStore else { fatalError("Client does not have a bookmark store") }
        self.bookmarkStore = store
        super.init(nibName: nil, bundle: nil)
        store.add(listener: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardAdjuster = ScrollViewKeyboardAdjuster(
            scrollView: collectionView,
            viewController: self
        )

        makeBackBarItemEmpty()

        view.backgroundColor = Styles.Colors.background

        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self

        searchBar.delegate = self
        searchBar.placeholder = Constants.Strings.searchBookmarks
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar

        searchBar.resignWhenKeyboardHides()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: collectionView)
        update(animated: animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let bounds = view.bounds
        if bounds != collectionView.frame {
            collectionView.frame = bounds
            collectionView.collectionViewLayout.invalidateForOrientationChange()
        }
    }
  
    override func viewWillDisappear(_ animated: Bool) {
      searchBar.resignFirstResponder()
    }


    private func update(animated: Bool) {
        adapter.performUpdates(animated: animated)
    }

    func filter(term: String?) {
        defer {
            update(animated: true)
        }

        guard let term = term?.trimmingCharacters(in: .whitespacesAndNewlines), !term.isEmpty else {
            state = .idle
            return
        }

        state = .filtering(term)
    }

    // MARK: BookmarkSectionControllerDelegate

    func didSelect(bookmarkSectionController: BookmarkSectionController, viewModel: BookmarkViewModel) {
        let bookmark = viewModel.bookmark
        let destinationViewController: UIViewController

        switch bookmark.type {
        case .repo:
            let repo = RepositoryDetails(
                owner: bookmark.owner,
                name: bookmark.name,
                defaultBranch: bookmark.defaultBranch,
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

    func didDelete(bookmarkSectionController: BookmarkSectionController, viewModel: BookmarkViewModel) {
        searchBar.resignFirstResponder()
        bookmarkStore.remove(viewModel.bookmark)
        update(animated: true)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let contentSizeCategory = UIContentSizeCategory.preferred
        let width = view.bounds.width
        var bookmarks: [ListDiffable]
        switch state {
        case .idle:
            bookmarks = bookmarkStore.values.compactMap {
                BookmarkViewModel(bookmark: $0, contentSizeCategory: contentSizeCategory, width: width)
            }
        case .filtering(let term):
            bookmarks = filtered(array: bookmarkStore.values, query: term)
                .compactMap {
                    BookmarkViewModel(bookmark: $0, contentSizeCategory: contentSizeCategory, width: width)
            }
        }

        if !bookmarks.isEmpty {
            bookmarks.insert(headerKey, at: 0)
        }

        return bookmarks
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError() }

        if object === headerKey {
            return BookmarkHeaderSectionController(delegate: self)
        } else if object is BookmarkViewModel {
            return BookmarkSectionController(delegate: self)
        }

        fatalError("Could not find section controller for object")
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        guard bookmarkStore.values.isEmpty else { return nil }

        let view = InitialEmptyView(
            imageName: "bookmarks-large",
            title: NSLocalizedString("Add Bookmarks", comment: ""),
            description: NSLocalizedString("Bookmark your favorite issues,\npull requests, and repositories.", comment: "")
        )
        view.delegate = self
        return view
    }

    // MARK: UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(term: searchBar.text)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filter(term: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        state = .idle
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()

        update(animated: true)
    }

    // MARK: BookmarkHeaderSectionControllerDelegate

    func didTapClear(sectionController: BookmarkHeaderSectionController) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Are you sure?", comment: ""),
            message: NSLocalizedString("All of your bookmarks will be lost. Do you want to continue?", comment: ""),
            preferredStyle: .alert
        )

        alert.addActions([
            AlertAction.clearAll { [weak self] _ in
                self?.bookmarkStore.clear()
                self?.update(animated: false)
            },
            AlertAction.cancel()
        ])

        present(alert, animated: true)
    }

    // MARK: InitialEmptyViewDelegate

    func didTap(emptyView: InitialEmptyView) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        collectionView.scrollToTop(animated: true)
    }

    func didDoubleTapTab() {
        searchBar.becomeFirstResponder()
    }

    // MARK: StoreListener

    func didUpdateStore() {
        update(animated: true)
    }

}
