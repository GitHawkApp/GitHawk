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
    let collectionView: UICollectionView

    public private(set) var status: Status = .idle
    private weak var delegate: FeedDelegate? = nil
    private let feedRefresh = FeedRefresh()
    private let managesLayout: Bool

    init(
        viewController: UIViewController,
        delegate: FeedDelegate,
        collectionView: UICollectionView? = nil,
        managesLayout: Bool = true
        ) {
        self.adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: viewController)
        self.delegate = delegate
        self.managesLayout = managesLayout
        self.collectionView = collectionView
            ?? DisableAutoScrollCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init()
        self.adapter.scrollViewDelegate = self

        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = Styles.Colors.background
        self.collectionView.refreshControl = feedRefresh.refreshControl
        self.collectionView.keyboardDismissMode = .onDrag
        feedRefresh.refreshControl.addTarget(self, action: #selector(Feed.onRefresh(sender:)), for: .valueChanged)
    }

    // MARK: Public API

    func refreshHead() {
        refresh()
        feedRefresh.beginRefreshing()
    }

    func viewDidLoad() {
        guard let view = adapter.viewController?.view else { return }

        refresh()

        adapter.collectionView = collectionView

        if collectionView.superview == nil {
            view.addSubview(collectionView)
        }

        feedRefresh.beginRefreshing()
    }

    func viewWillLayoutSubviews(view: UIView) {
        let bounds = view.bounds
        let changed = bounds != collectionView.frame
        if managesLayout && changed {
            collectionView.frame = bounds
        }
        if changed {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    func finishLoading(dismissRefresh: Bool, animated: Bool = true, completion: (() -> ())? = nil) {
        status = .idle

        adapter.performUpdates(animated: animated) { _ in
            if dismissRefresh {
                self.feedRefresh.endRefreshing(completion: {
                    completion?()
                })
            } else {
                completion?()
            }
        }
    }

    // MARK: Private API

    private func refresh() {
        guard status == .idle else { return }
        status = .loading
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

