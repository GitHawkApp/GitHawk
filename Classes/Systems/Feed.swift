//
//  Feed.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol FeedDelegate: class {
    func loadFromNetwork(feed: Feed)
    func loadNextPage(feed: Feed) -> Bool
}

// disables auto scrolling when text views are focused
private class DisableAutoScrollCollectionView: UICollectionView {
    override func scrollRectToVisible(_ rect: CGRect, animated: Bool) {}
}

final class Feed: NSObject, UIScrollViewDelegate {

    enum Status {
        case idle
        case loading
        case loadingNext
    }

    let adapter: ListAdapter
    lazy var collectionView: UICollectionView = {
        let view = DisableAutoScrollCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.keyboardDismissMode = .interactive
        view.alwaysBounceVertical = true
        view.backgroundColor = Styles.Colors.background
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
        super.init()
        self.adapter.scrollViewDelegate = self
    }

    // MARK: Public API

    func viewDidLoad() {
        guard let view = adapter.viewController?.view else { return }

        adapter.collectionView = collectionView

        view.addSubview(collectionView)

        collectionView.refreshControl?.beginRefreshing()
        refresh()
    }

    func viewWillLayoutSubviews(view: UIView) {
        let bounds = view.bounds
        if collectionView.frame != bounds {
            collectionView.frame = bounds
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    func finishLoading(dismissRefresh: Bool, animated: Bool = true) {
        status = .idle
        let block = {
            self.adapter.performUpdates(animated: animated) { _ in
                if dismissRefresh {
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
        guard status == .idle else { return }
        status = .loading
        refreshBegin = CFAbsoluteTimeGetCurrent()
        delegate?.loadFromNetwork(feed: self)
    }

    @objc private func onRefresh(sender: Any) {
        refresh()
    }

    // MARK: UIScrollViewDelegate

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let contentHeight = scrollView.contentSize.height
        let viewHeight = scrollView.bounds.height
        let currentTopOffset = scrollView.contentOffset.y
        let topTargetOffset = targetContentOffset.pointee.y

        guard status == .idle, // dont page if already loading something
            topTargetOffset - currentTopOffset > 0 // only page when scrolling to the bottom
            else { return }

        if topTargetOffset > contentHeight - viewHeight * 2 {
            if delegate?.loadNextPage(feed: self) == true {
                status = .loadingNext
            }
        }
    }

}

