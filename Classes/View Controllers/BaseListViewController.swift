//
//  BaseListViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol BaseListViewControllerDataSource: class {
    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair]
}

protocol BaseListViewControllerEmptyDataSource: class {
    func emptyModel(for adapter: ListSwiftAdapter) -> ListSwiftPair
}

protocol BaseListViewControllerHeaderDataSource: class {
    func headerModel(for adapter: ListSwiftAdapter) -> ListSwiftPair
}

class BaseListViewController<PageType: CustomStringConvertible>: UIViewController,
ListSwiftAdapterDataSource,
FeedDelegate,
LoadMoreSectionController2Delegate,
ListSwiftAdapterEmptyViewSource,
EmptyViewDelegate {

    private let emptyErrorMessage: String
    private let backgroundThreshold: CFTimeInterval?

    public weak var dataSource: BaseListViewControllerDataSource?
    public weak var emptyDataSource: BaseListViewControllerEmptyDataSource?
    public weak var headerDataSource: BaseListViewControllerHeaderDataSource?

    public private(set) lazy var feed: Feed = { Feed(
        viewController: self,
        delegate: self,
        backgroundThreshold: backgroundThreshold
        ) }()
    private var page: PageType?
    private var hasError = false

    init(emptyErrorMessage: String, backgroundThreshold: CFTimeInterval? = nil) {
        self.emptyErrorMessage = emptyErrorMessage
        self.backgroundThreshold = backgroundThreshold
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        feed.swiftAdapter.dataSource = self
        feed.swiftAdapter.emptyViewSource = self
        feed.viewDidLoad()
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

    func fetch(page: PageType?) {}

    // MARK: Public API

    final func update(animated: Bool = true) {
        self.feed.finishLoading(
            dismissRefresh: true,
            animated: animated && trueUnlessReduceMotionEnabled
        )
    }

    final func update(
        page: PageType?,
        animated: Bool = true,
        completion: (() -> Void)? = nil
        ) {
        assert(Thread.isMainThread)

        self.hasError = false
        self.page = page
        self.feed.finishLoading(
            dismissRefresh: true,
            animated: animated && trueUnlessReduceMotionEnabled,
            completion: completion
        )
    }

    final func error(
        animated: Bool = true,
        completion: (() -> Void)? = nil
        ) {
        assert(Thread.isMainThread)
        hasError = true
        feed.finishLoading(
            dismissRefresh: true,
            animated: animated && trueUnlessReduceMotionEnabled,
            completion: completion
        )
    }

    // MARK: FeedDelegate

    final func loadFromNetwork(feed: Feed) {
        assert(Thread.isMainThread)
        fetch(page: nil)
    }

    final func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: ListSwiftAdapterDataSource

    public func values(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        assert(Thread.isMainThread)
        guard let dataSource = self.dataSource else { return [] }

        let models = dataSource.models(adapter: adapter)
        let hasNoObjects = models.count == 0

        // short-circuit to display empty-error message using the emptyView(...) API
        if hasError && hasNoObjects {
            return []
        }

        let listModels: [ListSwiftPair]
        if let emptyDataSource = self.emptyDataSource,
            hasNoObjects,
            feed.status == .idle {
            listModels = [emptyDataSource.emptyModel(for: adapter)]
        } else if let page = self.page?.description {
            let pagePair = ListSwiftPair.pair(page) { [weak self] in
                let controller = LoadMoreSectionController2()
                controller.delegate = self
                return controller
            }
            listModels = models + [pagePair]
        } else {
            listModels = models
        }
        if let header = headerDataSource?.headerModel(for: adapter) {
            return [header] + listModels
        } else {
            return listModels
        }
    }

    // MARK: LoadMoreSectionController2Delegate

    func didSelect(controller: LoadMoreSectionController2) {
        fetch(page: page)
    }

    // MARK: ListSwiftAdapterEmptyViewSource

    func emptyView(adapter: ListSwiftAdapter) -> UIView? {
        guard hasError, feed.status != .initial else { return nil }
        let empty = EmptyView()
        empty.label.text = emptyErrorMessage
        empty.delegate = self
        empty.button.isHidden = false
        empty.accessibilityIdentifier = "base-empty-view"
        return empty
    }

    // MARK: EmptyViewDelegate

    func didTapRetry(view: EmptyView) {
        // order is required to hide the error empty view while loading
        feed.refreshHead()
        hasError = false
        feed.adapter.performUpdates(animated: false, completion: nil)
    }

}
