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
                            FeedDelegate,
                            SearchLoadMoreSectionControllerDelegate,
                            UISearchBarDelegate {

    private let client: GithubClient
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private var searchResults = [SearchResult]()
    private var nextPage: String?
    private var searchTerm: String? = "IGListKit"
    
    private let emptyKey = "emptyKey" as ListDiffable
    private let loadMore = "loadMore" as ListDiffable
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        
        return searchBar
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

        feed.viewDidLoad()
        feed.adapter.dataSource = self
        addSearchBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }
    
    // MARK: Search Bar
    
    func addSearchBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.searchTerm = text
            self.reload()
        }
    }
    
    // MARK: Data Loading/Paging
    
    private func update(dismissRefresh: Bool, animated: Bool = true) {
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
    }
    
    private func handle(resultType: GithubClient.SearchResultType, append: Bool, animated: Bool) {
        switch resultType {
        case .error:
            print("😞 Something went wrong, here's some pizza 🍕")
            break
        case .success(let nextPage, let results):
            if append {
                self.searchResults += results
            } else {
                self.searchResults = results
            }
            
            self.nextPage = nextPage
            self.update(dismissRefresh: !append, animated: animated)
            break
        }
    }
    
    func reload() {
        guard let searchTerm = searchTerm else { return }
        client.search(query: searchTerm) { [weak self] resultType in
            self?.handle(resultType: resultType, append: false, animated: true)
        }
    }
    
    func loadNextPage() {
        guard let nextPage = nextPage, let searchTerm = searchTerm else { return }
        client.search(query: searchTerm, before: nextPage) { [weak self] resultType in
            self?.handle(resultType: resultType, append: true, animated: false)
        }
    }
    
    // MARK: FeedDelegate
    
    func loadFromNetwork(feed: Feed) {
        reload()
    }
    
    func loadNextPage(feed: Feed) -> Bool {
        return false
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var builder = [ListDiffable]()
        
        if searchResults.count == 0 {
            builder.append(emptyKey)
        } else {
            builder += searchResults as [ListDiffable]
            
            if nextPage != nil {
                builder.append(loadMore)
            }
        }
        
        return builder
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }
        
        if object === emptyKey { return NoNewNotificationSectionController(topInset: 0, topLayoutGuide: topLayoutGuide) }
        else if object === loadMore { return SearchLoadMoreSectionController(delegate: self) }
        else if object is SearchResult { return SearchResultSectionController() }
        
        fatalError("Could not find section controller for object")
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    // MARK: SearchLoadMoreSectionControllerDelegate
    
    func didSelect(sectionController: SearchLoadMoreSectionController) {
        loadNextPage()
    }
}
