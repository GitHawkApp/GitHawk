//
//  BaseListViewController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol BaseListViewController2DataSource: class {
    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair]
}

class BaseListViewController2<PageType: CustomStringConvertible>: UIViewController,
ListSwiftAdapterDataSource,
FeedDelegate,
LoadMoreSectionController2Delegate {

    private let emptyErrorMessage: String
    public weak var dataSource: BaseListViewController2DataSource?

    public private(set) lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private var page: PageType?
    private var hasError = false
    private let emptyKey: ListDiffable = "emptyKey" as ListDiffable

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
        feed.swiftAdapter.dataSource = self
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

    final func update(animated: Bool) {
        self.feed.finishLoading(
            dismissRefresh: true,
            animated: animated && trueUnlessReduceMotionEnabled
        )
    }

    final func update(
        page: PageType?,
        animated: Bool,
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
        animated: Bool,
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

        if let page = self.page?.description {
            let pagePair = ListSwiftPair.pair(page) { [weak self] in
                let controller = LoadMoreSectionController2()
                controller.delegate = self
                return controller
            }
            return models + [pagePair]
        } else {
            return models
        }
    }

    // MARK: LoadMoreSectionController2Delegate

    func didSelect(controller: LoadMoreSectionController2) {
        fetch(page: page)
    }
    
}
