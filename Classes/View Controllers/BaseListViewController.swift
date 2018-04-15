//
//  BaseListViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

// Extension of ListAdapterDataSource to mixin our own features like paging controls
protocol BaseListViewControllerDataSource: class {
    // models that stick to the head of the list. not displayed on an empty error
    func headModels(listAdapter: ListAdapter) -> [ListDiffable]
    // the core "body" models in the list
    func models(listAdapter: ListAdapter) -> [ListDiffable]
    // section controllers for models in the list
    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController
    // a section controller for empty lists w/out error
    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController
}

/**
 Subclassable view controller with basic list features:
 - Composed list data with head and body contents
 - "Empty" section controller when body contents is missing
 - Error handling via IGListAdapterDataSource emptyView(...) API
 - Paging control when page is non-nil
 */
class BaseListViewController<PagingType: ListDiffable>: UIViewController,
ListAdapterDataSource,
FeedDelegate,
LoadMoreSectionControllerDelegate {

    // required on init
    private let emptyErrorMessage: String
    public weak var dataSource: BaseListViewControllerDataSource?

    public private(set) lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private var page: PagingType?
    private var hasError = false
    private let emptyKey: ListDiffable = "emptyKey" as ListDiffable
    private var filterQuery: String?

    init(emptyErrorMessage: String) {
        self.emptyErrorMessage = emptyErrorMessage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        feed.viewDidLoad()
        feed.adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: feed.collectionView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: Overridable API

    // override this method to do your own networking
    // if page is nil then you should request the very first page of content
    func fetch(page: PagingType?) {}

    // MARK: Public API

    final func update(animated: Bool) {
        self.feed.finishLoading(dismissRefresh: true, animated: animated)
    }

    final func update(
        page: PagingType?,
        animated: Bool,
        completion: (() -> Void)? = nil
        ) {
        assert(Thread.isMainThread)

        self.hasError = false
        self.page = page
        self.feed.finishLoading(dismissRefresh: true, animated: animated, completion: completion)
    }

    final func error(
        animated: Bool,
        completion: (() -> Void)? = nil
        ) {
        assert(Thread.isMainThread)
        hasError = true
        feed.finishLoading(dismissRefresh: true, animated: animated, completion: completion)
    }

    final func filter(query: String?, animated: Bool) {
        filterQuery = query
        feed.adapter.performUpdates(animated: animated)
    }

    // MARK: ListAdapterDataSource

    final func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        assert(Thread.isMainThread)
        guard let dataSource = self.dataSource else { return [] }

        let objects = dataSource.models(listAdapter: listAdapter)
        let hasNoObjects = objects.count == 0

        // short-circuit to display empty-error message using the emptyView(...) API
        if hasError && hasNoObjects {
            return []
        }

        var allObjects = dataSource.headModels(listAdapter: listAdapter)

        // if there are no objects and the feed is idle, show an empty control
        if hasNoObjects && feed.status == .idle {
            allObjects.append(emptyKey)
        } else {
            allObjects += objects

            // only append paging if there are visible objects
            if let page = self.page {
                allObjects.append(page)
            }
        }

        // if a query string exists, return matching Filterable objects
        if let query = filterQuery {
            return filtered(array: allObjects, query: query)
        } else {
            return allObjects
        }
    }

    final func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        assert(Thread.isMainThread)
        guard let object = object as? ListDiffable,
        let dataSource = self.dataSource
            else { fatalError("Object not diffable or missing data source") }
        if object === page {
            return LoadMoreSectionController(delegate: self)
        } else if object === emptyKey {
            return dataSource.emptySectionController(listAdapter: listAdapter)
        }
        return dataSource.sectionController(model: object, listAdapter: listAdapter)
    }

    final func emptyView(for listAdapter: ListAdapter) -> UIView? {
        assert(Thread.isMainThread)
        guard hasError else { return nil }
        let empty = EmptyView()
        empty.label.text = emptyErrorMessage
        return empty
    }

    // MARK: FeedDelegate

    final func loadFromNetwork(feed: Feed) {
        assert(Thread.isMainThread)
        fetch(page: nil)
    }

    final func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: LoadMoreSectionControllerDelegate

    final func didSelect(sectionController: LoadMoreSectionController) {
        fetch(page: page)
    }

}
