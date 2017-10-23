//
//  FeedRefreshControl.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class FeedRefresh {

    let refreshControl = UIRefreshControl()

    private var refreshBegin: TimeInterval = -1

    init() {
        refreshControl.addTarget(self, action: #selector(FeedRefresh.setRefreshing), for: .valueChanged)
    }

    // MARK: Public API

    func beginRefreshing() {
        refreshControl.beginRefreshing()
        if let scrollView = refreshControl.superview as? UIScrollView {
            scrollView.setContentOffset(
                CGPoint(x: 0, y: scrollView.contentOffset.y - refreshControl.bounds.height),
                animated: true
            )
        }
        setRefreshing()
    }

    @objc func setRefreshing() {
        refreshBegin = CFAbsoluteTimeGetCurrent()
    }

    func endRefreshing(updates: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let block = {
            updates?()

            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.refreshControl.endRefreshing()
            CATransaction.commit()
        }

        // delay the refresh control dismissal so the UI isn't too spazzy on fast or non-existent connections
        let remaining = 0.5 - (CFAbsoluteTimeGetCurrent() - refreshBegin)
        if remaining > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + remaining, execute: block)
        } else {
            block()
        }
    }

}
