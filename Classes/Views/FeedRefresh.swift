//
//  FeedRefreshControl.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class FeedRefresh {

    let refreshControl = GitHawkRefreshControl()

    private var refreshBegin: TimeInterval = -1

    init() {
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(FeedRefresh.setRefreshing), for: .valueChanged)
    }

    // MARK: Public API

    func beginRefreshing() {
        refreshControl.beginRefreshing()
        if let scrollView = refreshControl.superview as? UIScrollView {
            let contentOffset = scrollView.contentOffset
            scrollView.setContentOffset(
                CGPoint(
                    x: contentOffset.x,
                    y: contentOffset.y - refreshControl.bounds.height),
                animated: trueUnlessReduceMotionEnabled
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
