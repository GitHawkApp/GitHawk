//
//  SearchViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class SearchViewController: UIViewController,
    ListAdapterDataSource,
    PrimaryViewController,
    UISearchBarDelegate,
SearchEmptyViewDelegate {

    private let client: GithubClient
    private let noResultsKey = "noResultsKey" as ListDiffable

    enum State {
        case idle
        case loading
        case results([ListDiffable])
        case error
    }
    private var state: State = .idle

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

        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self

        searchBar.delegate = self
        searchBar.placeholder = NSLocalizedString("Search", comment: "")
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
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

    // MARK: Data Loading/Paging

    private func update(animated: Bool) {
        adapter.performUpdates(animated: animated)
    }

    private func handle(resultType: GithubClient.SearchResultType, animated: Bool) {
        switch resultType {
        case .error:
            self.state = .error
        case .success(_, let results):
            self.state = .results(results)
        }
        self.update(animated: animated)
    }

    func search(term: String) {
        state = .loading
        update(animated: false)

        client.search(query: term, containerWidth: view.bounds.width) { [weak self] resultType in
            self?.handle(resultType: resultType, animated: true)
        }
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        switch state {
        case .error, .idle, .loading:
            return []
        case .results(let models):
            return models
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }

        let controlHeight = Styles.Sizes.tableCellHeight
        if object === noResultsKey { return SearchNoResultsSectionController(topInset: controlHeight, topLayoutGuide: topLayoutGuide) }
        else if object is SearchRepoResult { return SearchResultSectionController(client: client) }

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
        case .error, .results:
            return nil
        }
    }

    // MARK: UISearchBarDelegate

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let term = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            term.characters.count > 0
            else { return }
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
    
}
