//
//  PageboyScrollDetection.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

// MARK: - UIPageViewControllerDelegate, UIScrollViewDelegate
extension PageboyViewController: UIPageViewControllerDelegate {
    
    // MARK: UIPageViewControllerDelegate
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   willTransitionTo pendingViewControllers: [UIViewController]) {
        guard pageViewControllerIsActual(pageViewController) else {
            return
        }

        self.pageViewController(pageViewController,
                                willTransitionTo: pendingViewControllers,
                                animated: false)
    }
    
    internal func pageViewController(_ pageViewController: UIPageViewController,
                                     willTransitionTo pendingViewControllers: [UIViewController],
                                     animated: Bool) {
        guard pageViewControllerIsActual(pageViewController) else {
            return
        }
        guard let viewController = pendingViewControllers.first,
            let index = viewControllerMap.index(forObjectAfter: { return $0.object === viewController }) else {
                return
        }
        
        self.expectedTransitionIndex = index
        let direction = NavigationDirection.forPage(index, previousPage: self.currentIndex ?? index)
        self.delegate?.pageboyViewController(self, willScrollToPageAt: index,
                                             direction: direction,
                                             animated: animated)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {
        guard pageViewControllerIsActual(pageViewController), completed else {
            return }
        
        if let viewController = pageViewController.viewControllers?.first,
            let index = viewControllerMap.index(forObjectAfter: { return $0.object === viewController }) {
            guard index == self.expectedTransitionIndex else {
                return
            }
            
            self.updateCurrentPageIndexIfNeeded(index)
        }
    }

    // TODO - Enable this when issue in iOS 11.2 is resolved.
    //
    // See here: https://github.com/uias/Pageboy/issues/128
    //
//    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        guard showsPageControl else {
//            return -1
//        }
//        return pageCount ?? 0
//    }
//
//    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard showsPageControl else {
//            return -1
//        }
//        return targetIndex ?? 0
//    }
}

extension PageboyViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollViewIsActual(scrollView) else {
            return
        }
        
        guard self.updateContentOffsetForBounceIfNeeded(scrollView: scrollView) == false else {
            return
        }
        
        guard let currentIndex = self.currentIndex else {
            return
        }
        
        let previousPagePosition = self.previousPagePosition ?? 0.0
        let (pageSize, contentOffset) = calculateRelativePageSizeAndContentOffset(for: scrollView)
        
        guard let scrollIndexDiff = self.pageScrollIndexDiff(forCurrentIndex: currentIndex,
                                                             expectedIndex: self.expectedTransitionIndex,
                                                             currentContentOffset: contentOffset,
                                                             pageSize: pageSize) else {
                                                                return
        }
        guard var pagePosition = self.pagePosition(forContentOffset: contentOffset,
                                                   pageSize: pageSize,
                                                   indexDiff: scrollIndexDiff) else {
                                                    return
        }
        
        // do not continue if a page change is detected
        guard !self.detectCurrentPageIndexIfNeeded(pagePosition: pagePosition,
                                                   scrollView: scrollView) else {
                                                    return
        }
        
        // do not continue if previous position equals current
        if previousPagePosition == pagePosition {
            return
        }
        
        // update relative page position for infinite overscroll if required
        self.detectInfiniteOverscrollIfNeeded(pagePosition: &pagePosition)
        
        // provide scroll updates
        var positionPoint: CGPoint!
        let direction = NavigationDirection.forPosition(pagePosition, previous: previousPagePosition)
        if self.navigationOrientation == .horizontal {
            positionPoint = CGPoint(x: pagePosition, y: scrollView.contentOffset.y)
        } else {
            positionPoint = CGPoint(x: scrollView.contentOffset.x, y: pagePosition)
        }
        
        // ignore duplicate updates
        guard self.currentPosition != positionPoint else {
            return
        }
        self.currentPosition = positionPoint
        self.delegate?.pageboyViewController(self,
                                             didScrollTo: positionPoint,
                                             direction: direction,
                                             animated: self.isScrollingAnimated)
        
        self.previousPagePosition = pagePosition
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        ensureScrollViewIsActual(scrollView: scrollView, then: {
            if self.autoScroller.cancelsOnScroll {
                self.autoScroller.cancel()
            }
        })
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        ensureScrollViewIsActual(scrollView: scrollView, then: {
            self.scrollView(didEndScrolling: scrollView)
        })
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        ensureScrollViewIsActual(scrollView: scrollView, then: {
            self.scrollView(didEndScrolling: scrollView)
        })
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        ensureScrollViewIsActual(scrollView: scrollView, then: {
            self.updateContentOffsetForBounceIfNeeded(scrollView: scrollView)
        })
    }
    
    private func scrollView(didEndScrolling scrollView: UIScrollView) {
        ensureScrollViewIsActual(scrollView: scrollView, then: {
            if self.autoScroller.restartsOnScrollEnd {
                self.autoScroller.restart()
            }
        })
    }
    
    private func ensureScrollViewIsActual(scrollView: UIScrollView, then action: () -> Void) {
        if scrollViewIsActual(scrollView) {
            action()
        }
    }
}

// MARK: - Calculations
private extension PageboyViewController {
    
    /// Calculate the relative page size and content offset for a scroll view at its current position.
    ///
    /// - Parameter scrollView: Scroll View
    /// - Returns: Relative page size and content offset.
    private func calculateRelativePageSizeAndContentOffset(for scrollView: UIScrollView) -> (CGFloat, CGFloat) {
        var pageSize: CGFloat
        var contentOffset: CGFloat
        switch navigationOrientation {
            
        case .horizontal:
            pageSize = scrollView.frame.size.width
            if scrollView.layoutIsRightToLeft {
                contentOffset = pageSize + (pageSize - scrollView.contentOffset.x)
            } else {
                contentOffset = scrollView.contentOffset.x
            }
            
        case .vertical:
            pageSize = scrollView.frame.size.height
            contentOffset = scrollView.contentOffset.y
        }
        
        return (pageSize, contentOffset)
    }
    
    /// Detect whether the scroll view is overscrolling while infinite scroll is enabled
    /// Adjusts pagePosition if required.
    ///
    /// - Parameter pagePosition: the relative page position.
    private func detectInfiniteOverscrollIfNeeded(pagePosition: inout CGFloat) {
        guard self.isInfinitelyScrolling(forPosition: pagePosition) else {
            return
        }
        
        let maxPagePosition = CGFloat((self.viewControllerCount ?? 1) - 1)
        var integral: Double = 0.0
        var progress = CGFloat(modf(fabs(Double(pagePosition)), &integral))
        var maxInfinitePosition: CGFloat!
        if pagePosition > 0.0 {
            progress = 1.0 - progress
            maxInfinitePosition = 0.0
        } else {
            maxInfinitePosition = maxPagePosition
        }
        
        var infinitePagePosition = maxPagePosition * progress
        if fmod(progress, 1.0) == 0.0 {
            infinitePagePosition = maxInfinitePosition
        }
        
        pagePosition = infinitePagePosition
    }
    
    /// Whether a position is infinitely scrolling between end ranges
    ///
    /// - Parameter pagePosition: The position.
    /// - Returns: Whether the position is infinitely scrolling.
    private func isInfinitelyScrolling(forPosition pagePosition: CGFloat) -> Bool {
        let maxPagePosition = CGFloat((self.viewControllerCount ?? 1) - 1)
        let overscrolling = pagePosition < 0.0 || pagePosition > maxPagePosition
        
        guard self.isInfiniteScrollEnabled && overscrolling else {
            return false
        }
        return true
    }
    
    /// Detects whether a page boundary has been passed.
    /// As pageViewController:didFinishAnimating is not reliable.
    ///
    /// - Parameters:
    ///   - pageOffset: The current page scroll offset
    ///   - scrollView: The scroll view that is being scrolled.
    /// - Returns: Whether a page transition has been detected.
    private func detectCurrentPageIndexIfNeeded(pagePosition: CGFloat, scrollView: UIScrollView) -> Bool {
        guard var currentIndex = self.currentIndex else {
            return false
        }
        
        // Handle scenario where user continues to pan past a single page range.
        let isPagingForward = pagePosition > self.previousPagePosition ?? 0.0
        if scrollView.isTracking {
            if isPagingForward && pagePosition >= CGFloat(currentIndex + 1) {
                self.updateCurrentPageIndexIfNeeded(currentIndex + 1)
                return true
            } else if !isPagingForward && pagePosition <= CGFloat(currentIndex - 1) {
                self.updateCurrentPageIndexIfNeeded(currentIndex - 1)
                return true
            }
        }
        
        let isOnPage = pagePosition.truncatingRemainder(dividingBy: 1) == 0
        if isOnPage {
            
            // Special case where scroll view might be decelerating but on a new index,
            // and UIPageViewController didFinishAnimating is not called
            if scrollView.isDecelerating {
                currentIndex = Int(pagePosition)
            }
            
            return updateCurrentPageIndexIfNeeded(currentIndex)
        }
        
        return false
    }
    
    /// Safely update the current page index.
    ///
    /// - Parameter index: the proposed index.
    /// - Returns: Whether the page index was updated.
    @discardableResult
    private func updateCurrentPageIndexIfNeeded(_ index: Int) -> Bool {
        guard self.currentIndex != index, index >= 0 &&
            index < self.viewControllerCount ?? 0 else {
                return false
        }
        self.currentIndex = index
        return true
    }
    
    /// Calculate the expected index diff for a page scroll.
    ///
    /// - Parameters:
    ///   - index: The current index.
    ///   - expectedIndex: The target page index.
    ///   - currentContentOffset: The current content offset.
    ///   - pageSize: The size of each page.
    /// - Returns: The expected index diff.
    private func pageScrollIndexDiff(forCurrentIndex index: Int?,
                                     expectedIndex: Int?,
                                     currentContentOffset: CGFloat,
                                     pageSize: CGFloat) -> CGFloat? {
        guard let index = index else {
            return nil
        }
        
        let expectedIndex = expectedIndex ?? index
        let expectedDiff = CGFloat(max(1, abs(expectedIndex - index)))
        let expectedPosition = self.pagePosition(forContentOffset: currentContentOffset,
                                                 pageSize: pageSize,
                                                 indexDiff: expectedDiff) ?? CGFloat(index)
        
        guard self.isInfinitelyScrolling(forPosition: expectedPosition) == false else {
            return 1
        }
        return expectedDiff
    }
    
    /// Calculate the relative page position.
    ///
    /// - Parameters:
    ///   - contentOffset: The current contentOffset.
    ///   - pageSize: The current page size.
    ///   - indexDiff: The expected difference between current / target page indexes.
    /// - Returns: The relative page position.
    private func pagePosition(forContentOffset contentOffset: CGFloat,
                              pageSize: CGFloat,
                              indexDiff: CGFloat) -> CGFloat? {
        guard let currentIndex = self.currentIndex else {
            return nil
        }
        
        let scrollOffset = contentOffset - pageSize
        let pageOffset = (CGFloat(currentIndex) * pageSize) + (scrollOffset * indexDiff)
        let position = pageOffset / pageSize
        return position.isFinite ? position : 0
    }
    
    /// Update the scroll view contentOffset for bouncing preference if required.
    ///
    /// - Parameter scrollView: The scroll view.
    /// - Returns: Whether the contentOffset was manipulated to achieve bouncing preference.
    @discardableResult private func updateContentOffsetForBounceIfNeeded(scrollView: UIScrollView) -> Bool {
        guard self.bounces == false else {
            return false
        }
        
        let previousContentOffset = scrollView.contentOffset
        if self.currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0.0)
        }
        if self.currentIndex == (self.viewControllerCount ?? 1) - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0.0)
        }
        return previousContentOffset != scrollView.contentOffset
    }
    
    // MARK: Utilities
    
    /// Check that a scroll view is the actual page view controller managed instance.
    ///
    /// - Parameter scrollView: The scroll view to check.
    /// - Returns: Whether it is the actual managed instance.
    private func scrollViewIsActual(_ scrollView: UIScrollView) -> Bool {
        return scrollView === pageViewController?.scrollView
    }
    
    /// Check that a UIPageViewController is the actual managed instance.
    ///
    /// - Parameter pageViewController: The page view controller to check.
    /// - Returns: Whether it is the actual managed instance.
    private func pageViewControllerIsActual(_ pageViewController: UIPageViewController) -> Bool {
        return pageViewController === self.pageViewController
    }
}
