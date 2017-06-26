//
//  Feed.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

protocol FeedDelegate: class {
    func loadFromNetwork(feed: Feed)
}

final class Feed {

    enum Status {
        case idle
        case loading
    }

    let adapter: ListAdapter
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.alwaysBounceVertical = true
        view.backgroundColor = UIColor.groupTableViewBackground
        view.refreshControl = UIRefreshControl()
        view.refreshControl?.addTarget(self, action: #selector(Feed.onRefresh(sender:)), for: .valueChanged)
        return view
    }()

    public private(set) var status: Status = .idle
    private weak var delegate: FeedDelegate? = nil
    private var refreshBegin: TimeInterval = -1

    init(viewController: UIViewController, delegate: FeedDelegate) {
        self.adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: viewController)
        self.delegate = delegate
    }

    // MARK: Public API

    func viewDidLoad() {
        guard let view = adapter.viewController?.view else { return }

        adapter.collectionView = collectionView

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        collectionView.refreshControl?.beginRefreshing()
        refresh()
    }

    func finishLoading(fromNetwork: Bool) {
        status = .idle
        let block = {
            self.adapter.performUpdates(animated: true) { _ in
                if fromNetwork {
                    self.collectionView.refreshControl?.endRefreshing()
                }
            }
        }

        // delay the refresh control dismissal so the UI isn't too spazzy on fast or non-existent connections
        let remaining = 0.5 - (CFAbsoluteTimeGetCurrent() - refreshBegin)
        if remaining > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + remaining, execute: block)
        } else {
            block()
        }
    }

    // MARK: Private API

    private func refresh() {
        status = .loading
        refreshBegin = CFAbsoluteTimeGetCurrent()
        delegate?.loadFromNetwork(feed: self)
    }

    @objc private func onRefresh(sender: Any) {
        refresh()
    }

}
