//
//  SearchViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import Apollo

class SearchViewController: UIViewController,
    ListAdapterDataSource,
    PrimaryViewController,
    UISearchBarDelegate,
SearchEmptyViewDelegate,
SearchRecentSectionControllerDelegate,
SearchRecentHeaderSectionControllerDelegate,
TabNavRootViewControllerType,
SearchResultSectionControllerDelegate {

    private let client: GithubClient
    private let noResultsKey = "com.freetime.SearchViewController.no-results-key" as ListDiffable
    private let recentHeaderKey = "com.freetime.SearchViewController.recent-header-key" as ListDiffable
    private let recentStore = SearchRecentStore()
    private let debouncer = Debouncer()

    enum State {
        case idle
        case loading(Cancellable?)
        case results([ListDiffable])
        case error
    }
    private var state: State = .idle {
        willSet {
            if case let .loading(request) = state {
                request?.cancel()
            }
        }
    }

    private let searchBar = UISearchBar()
    private lazy var adapter: ListAdapter = { ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.alwaysBounceVertical = true
        view.backgroundColor = Styles.Colors.background
        return view
    }()

    init(client: GithubClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Styles.Colors.background

        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self

        searchBar.delegate = self
        searchBar.placeholder = Constants.Strings.search
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar

        let nc = NotificationCenter.default
        nc.addObserver(
            self,
            selector: #selector(onKeyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil
        )
        nc.addObserver(
            self,
            selector: #selector(onKeyboardWillHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil
        )
        
        nc.addObserver(
            searchBar,
            selector: #selector(UISearchBar.resignFirstResponder),
            name: .UIKeyboardWillHide,
            object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: collectionView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let bounds = view.bounds
        if bounds != collectionView.frame {
            collectionView.frame = bounds
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    // MARK: Notifications

    @objc
    func onKeyboardWillShow(notification: NSNotification) {
        guard let frame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        let converted = view.convert(frame, from: nil)
        let intersection = converted.intersection(frame)
        let bottomInset = intersection.height - bottomLayoutGuide.length
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        collectionView.contentInset = inset
        collectionView.scrollIndicatorInsets = inset
    }

    @objc
    func onKeyboardWillHide(notification: NSNotification) {
        collectionView.contentInset = .zero
        collectionView.scrollIndicatorInsets = .zero
    }

    // MARK: Data Loading/Paging

    private func update(animated: Bool) {
        adapter.performUpdates(animated: animated)
    }

    private func handle(resultType: GithubClient.SearchResultType, animated: Bool) {
        switch resultType {
        case let .error(error) where isCancellationError(error):
            self.state = .loading(nil)
        case .error:
            self.state = .error
        case .success(_, let results):
            self.state = .results(results)
        }
        self.update(animated: animated)
    }

    func search(term: String) {
        recentStore.add(query: .search(term))

        let request = client.search(query: term, containerWidth: view.bounds.width) { [weak self] resultType in
            guard let state = self?.state, case .loading = state else { return }
            self?.handle(resultType: resultType, animated: true)
        }
        state = .loading(request)

        update(animated: false)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        switch state {
        case .idle:
            var recents: [ListDiffable] = recentStore.recents.flatMap { SearchRecentViewModel(query: $0) }
            if recents.count > 0 {
                recents.insert(recentHeaderKey, at: 0)
            }
            return recents
        case .error, .loading:
            return []
        case .results(let models):
            return models.count > 0 ? models : [noResultsKey]
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }

        let controlHeight = Styles.Sizes.tableCellHeight
        if object === noResultsKey {
            return SearchNoResultsSectionController(
                topInset: controlHeight,
                topLayoutGuide: topLayoutGuide,
                bottomLayoutGuide: bottomLayoutGuide
            )
        } else if object === recentHeaderKey {
            return SearchRecentHeaderSectionController(delegate: self)
        } else if object is SearchRepoResult {
            return SearchResultSectionController(client: client, delegate: self)
        } else if object is SearchRecentViewModel {
            return SearchRecentSectionController(delegate: self)
        }

        fatalError("Could not find section controller for object")
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch state {
        case .idle:
            let view = SearchEmptyView()
            view.delegate = self
            return view
        case .loading:
            return SearchLoadingView()
        case .error:
            let view = EmptyView()
            view.label.text = NSLocalizedString("Error finding results", comment: "")
            return view
         case .results:
            return nil
        }
    }

    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let term = searchTerm(for: searchBar.text) else {
            state = .idle
            update(animated: false)
            return
        }

        if case .loading = state {
            recentStore.removeLast()
        }

        debouncer.action = { [weak self] in self?.search(term: term) }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        debouncer.cancel()

        guard let term = searchTerm(for: searchBar.text) else { return }
        search(term: term)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()

        state = .idle
        update(animated: false)
    }
    
    // MARK: SearchEmptyViewDelegate

    func didTap(emptyView: SearchEmptyView) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

    // MARK: SearchRecentSectionControllerDelegate

    func didSelect(recentSectionController: SearchRecentSectionController, viewModel: SearchRecentViewModel) {
        searchBar.resignFirstResponder()

        if case let .search(text) = viewModel.query {
            didSelectSearch(text: text)
        } else if case let .recentlyViewed(repo) = viewModel.query {
            didSelectRepo(repo: repo)
        }
    }

    private func didSelectSearch(text: String) {
        searchBar.setShowsCancelButton(true, animated: false)
        searchBar.text = text
        search(term: text)
    }

    private func didSelectRepo(repo: RepositoryDetails) {
        recentStore.add(query: .recentlyViewed(repo))
        update(animated: false)

        let repoViewController = RepositoryViewController(client: client, repo: repo)
        let navigation = UINavigationController(rootViewController: repoViewController)
        showDetailViewController(navigation, sender: nil)
    }

    // MARK: SearchRecentHeaderSectionControllerDelegate

    func didTapClear(sectionController: SearchRecentHeaderSectionController) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Recent Searches", comment: ""),
            message: NSLocalizedString("Remove all recent searches?", comment: ""),
            preferredStyle: .alert
        )
        
        alert.addActions([
            AlertAction.clearAll({ [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.recentStore.clear()
                strongSelf.adapter.performUpdates(animated: true)
            }),
            AlertAction.cancel()
        ])
        
        present(alert, animated: true)
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        collectionView.scrollToTop(animated: true)
    }

    func didDoubleTapTab() {
        searchBar.becomeFirstResponder()
    }

    // MARK: SearchResultSectionControllerDelegate

    func didSelect(sectionController: SearchResultSectionController, repo: RepositoryDetails) {
        recentStore.add(query: .recentlyViewed(repo))
        update(animated: false)
        searchBar.resignFirstResponder()
    }

    func didDelete(recentSectionController: SearchRecentSectionController, viewModel: SearchRecentViewModel) {
        recentStore.remove(query: viewModel.query)
        update(animated: true)
    }

    // MARK: Private API

    private func searchTerm(for searchBarText: String?) -> String? {
        guard let term = searchBarText?.trimmingCharacters(in: .whitespacesAndNewlines),
            !term.isEmpty else { return nil }
        return term
    }
}
