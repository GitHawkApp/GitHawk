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
    private weak var dataSource: BaseListViewControllerDataSource? = nil

    public private(set) lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private var models = [ListDiffable]()
    private var page: PagingType? = nil
    private var hasError = false
    private let emptyKey: ListDiffable = "emptyKey" as ListDiffable

    init(
        emptyErrorMessage: String,
        dataSource: BaseListViewControllerDataSource
        ) {
        self.emptyErrorMessage = emptyErrorMessage
        self.dataSource = dataSource
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

    func update(
        models: [ListDiffable],
        page: PagingType?,
        append: Bool,
        animated: Bool,
        completion: (() -> ())? = nil
        ) {
        assert(Thread.isMainThread)
        if append {
            self.models += models
        } else {
            self.models = models
        }

        self.hasError = false
        self.page = page
        feed.finishLoading(dismissRefresh: true, animated: animated, completion: completion)
    }

    func error(
        animated: Bool,
        completion: (() -> ())? = nil
        ) {
        assert(Thread.isMainThread)
        hasError = true
        feed.finishLoading(dismissRefresh: true, animated: animated, completion: completion)
    }

    func performUpdate() {
        feed.finishLoading(dismissRefresh: false)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        assert(Thread.isMainThread)
        guard let dataSource = self.dataSource else { return [] }

        let objects = models
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

        return allObjects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
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

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        assert(Thread.isMainThread)
        return nil
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        assert(Thread.isMainThread)
        fetch(page: nil)
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: LoadMoreSectionControllerDelegate

    func didSelect(sectionController: LoadMoreSectionController) {
        fetch(page: page)
    }

}
