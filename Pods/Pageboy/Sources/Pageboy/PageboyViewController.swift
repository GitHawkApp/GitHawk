//
//  PageboyViewController.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 04/01/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

/// A simple, highly informative page view controller.
open class PageboyViewController: UIViewController {
    
    // MARK: Types
    
    /// A page index.
    public typealias PageIndex = Int
    /// Completion of a page scroll.
    public typealias PageScrollCompletion = (_ newViewController: UIViewController, _ animated: Bool, _ finished: Bool) -> Void

    /// The direction that the page view controller travelled.
    ///
    /// - neutral: No movement.
    /// - forward: Moved in a positive direction.
    /// - reverse: Moved in a negative direction.
    public enum NavigationDirection {
        case neutral
        case forward
        case reverse
    }
    
    /// The index of a page in the page view controller.
    ///
    /// - next: The next page if available.
    /// - previous: The previous page if available.
    /// - first: The first page.
    /// - last: The last page.
    /// - at: A custom specified page index.
    public enum Page {
        case next
        case previous
        case first
        case last
        case at(index: PageIndex)
    }
    
    // MARK: Properties
    
    internal var pageViewController: UIPageViewController?
    internal var previousPagePosition: CGFloat?
    internal var expectedTransitionIndex: PageIndex?

    /// The orientation that the page view controller transitions on.
    public var navigationOrientation: UIPageViewControllerNavigationOrientation = .horizontal {
        didSet {
            reconfigurePageViewController()
        }
    }
    /// The spacing between pages.
    public var interPageSpacing: CGFloat = 0.0 {
        didSet {
            reconfigurePageViewController()
        }
    }
    
    #if os(iOS)
    
    /// Preferred status bar style of the current view controller.
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let currentViewController = self.currentViewController {
            return currentViewController.preferredStatusBarStyle
        }
        return super.preferredStatusBarStyle
    }
    /// Preferred status bar hidden of the current view controller.
    open override var prefersStatusBarHidden: Bool {
        if let currentViewController = self.currentViewController {
            return currentViewController.prefersStatusBarHidden
        }
        return super.prefersStatusBarHidden
    }
    
    #endif
    
    /// The object that is the data source for the page view controller. (Defaults to self)
    public weak var dataSource: PageboyViewControllerDataSource? {
        didSet {
            self.reloadPages()
        }
    }
    /// The object that is the delegate for the page view controller.
    public weak var delegate: PageboyViewControllerDelegate?
    
    
    // default is YES. if NO, we immediately call -touchesShouldBegin:withEvent:inContentView:. this has no effect on presses
    public var delaysContentTouches: Bool = true {
        didSet {
            self.pageViewController?.scrollView?.delaysContentTouches = delaysContentTouches
        }
    }
    /// default YES. if YES, bounces past edge of content and back again.
    public var bounces: Bool = true
    // Whether client content appears on both sides of each page. If 'NO', content on page front will partially show through back.
    // If 'UIPageViewControllerSpineLocationMid' is set, 'doubleSided' is set to 'YES'. Setting 'NO' when spine location is mid results in an exception.
    public var isDoubleSided: Bool = false {
        didSet {
            self.pageViewController?.isDoubleSided = isDoubleSided
        }
    }
    
    /// Whether the page view controller is currently being touched.
    public var isTracking: Bool {
        return self.pageViewController?.scrollView?.isTracking ?? false
    }
    /// Whether the page view controller is currently being dragged.
    public var isDragging: Bool {
            return self.pageViewController?.scrollView?.isDragging ?? false
    }
    // Wether the user isn't dragging (touch up) but page view controller is still moving.
    public var isDecelerating: Bool {
        return self.pageViewController?.scrollView?.isDecelerating ?? false
    }
    /// Whether user interaction is enabled on the page view controller.
    ///
    /// Default is TRUE
    public var isUserInteractionEnabled: Bool = true {
        didSet {
            self.pageViewController?.scrollView?.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }
    /// Whether scroll is enabled on the page view controller.
    ///
    /// Default is TRUE.
    public var isScrollEnabled: Bool = true {
        didSet {
            self.pageViewController?.scrollView?.isScrollEnabled = isScrollEnabled
        }
    }
    /// Whether the page view controller should infinitely scroll at the end of page ranges.
    ///
    /// Default is FALSE.
    public var isInfiniteScrollEnabled: Bool = false {
        didSet {
            self.reloadCurrentPageSoftly()
        }
    }
    /// Whether the page view controller is currently animating a scroll between pages.
    private(set) var isScrollingAnimated = false {
        didSet {
            self.isUserInteractionEnabled = !self.isScrollingAnimated
        }
    }
    
    /// The transition to use when animating scrolls between pages.
    public var transition = Transition.defaultTransition
    /// The display link for transitioning.
    internal var transitionDisplayLink: CADisplayLink?
    /// The active transition operation.
    internal var activeTransition: TransitionOperation?
    
    /// The number of view controllers in the page view controller.
    internal var viewControllerCount: Int?
    /// A map of view controllers and related page indexes.
    internal var viewControllerMap = IndexedMap<WeakWrapper<UIViewController>>()
    
    /// The number of pages in the page view controller.
    public var pageCount: Int? {
        return viewControllerCount
    }
    
    /// The page index that is currently the target of a transition. This will align with currentIndex if no transition is active.
    internal var targetIndex: PageIndex?
    /// The page index that the page view controller is currently at.
    public internal(set) var currentIndex: PageIndex? {
        didSet {
            self.targetIndex = currentIndex
            guard let currentIndex = self.currentIndex else { return }

            #if os(iOS)
            UIView.animate(withDuration: 0.3) { 
                self.setNeedsStatusBarAppearanceUpdate()
            }
            #endif
            
            // ensure position keeps in sync
            self.currentPosition = CGPoint(x: self.navigationOrientation == .horizontal ? CGFloat(currentIndex) : 0.0,
                                           y: self.navigationOrientation == .vertical ? CGFloat(currentIndex) : 0.0)
            let direction = NavigationDirection.forPosition(CGFloat(currentIndex),
                                                            previous: CGFloat(oldValue ?? currentIndex))
            self.delegate?.pageboyViewController(self,
                                                 didScrollToPageAt: currentIndex,
                                                 direction: direction,
                                                 animated: self.isScrollingAnimated)

        }
    }
    /// The relative page position that the page view controller is currently at.
    public internal(set) var currentPosition: CGPoint?
    /// The view controller that the page view controller is currently at.
    public weak var currentViewController: UIViewController? {
        get {
            guard let currentIndex = self.currentIndex,
                viewControllerCount ?? 0 > currentIndex else {
                return nil
            }
            return self.pageViewController?.viewControllers?.last
        }
    }
    /// Whether the page view controller position is currently resting on a page index.
    internal var isPositionedOnPageIndex: Bool {
        let currentPosition = navigationOrientation == .horizontal ? self.currentPosition?.x : self.currentPosition?.y
        return currentPosition?.truncatingRemainder(dividingBy: 1) == 0
    }
    
    /// Auto Scroller for automatic time-based page transitions.
    public let autoScroller = PageboyAutoScroller()
    
    /// Whether to show the built-in UIPageViewController page control.
    @available(*, deprecated: 1.2.0, message: "Temporarily unavailable due to iOS 11.2 UIPageViewController issue. See here: https://github.com/uias/Pageboy/issues/128")
    public var showsPageControl: Bool = false
    
    // MARK: Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.autoScroller.handler = self
        self.setUpPageViewController()
    }

    open override func viewWillTransition(to size: CGSize,
                                          with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // ignore scroll updates during orientation change
        self.pageViewController?.scrollView?.delegate = nil
        coordinator.animate(alongsideTransition: nil) { (context) in
            self.pageViewController?.scrollView?.delegate = self
        }
    }
    
    // MARK: Updating
    
    /// Scroll the page view controller to a new page.
    ///
    /// - parameter page:      The index of the new page.
    /// - parameter animated:   Whether to animate the transition.
    /// - parameter completion: The completion closure.
    /// - Returns: Whether the scroll was executed.
    @discardableResult
    public func scrollToPage(_ page: Page,
                             animated: Bool,
                             completion: PageScrollCompletion? = nil) -> Bool {
        guard let pageViewController = self.pageViewController else {
            return false
        }
        
        // guard against any active interactive scrolling
        guard pageViewController.scrollView?.isProbablyActiveInScroll == false &&
            self.isPositionedOnPageIndex else {
            return false
        }
        
        // guard against any current transition operation
        guard self.isScrollingAnimated == false else { return false }
        
        let rawIndex = self.indexValue(for: page)
        if rawIndex != self.currentIndex {
            
            // guard against invalid page indexing
            guard rawIndex >= 0 && rawIndex < viewControllerCount ?? 0 else { return false }
            guard let viewController = viewController(at: rawIndex) else { return false }
            
            var direction = NavigationDirection.forPage(rawIndex, previousPage: self.currentIndex ?? rawIndex)
            
            if isInfiniteScrollEnabled {
                switch page {
                case .next:
                    direction = .forward
                case .previous:
                    direction = .reverse
                default: break
                }
            }
            
            self.pageViewController(pageViewController,
                                    willTransitionTo: [viewController],
                                    animated: animated)
            
            self.isScrollingAnimated = animated
            
            let transitionCompletion: TransitionOperation.Completion = { (finished) in
                if finished {
                    let isVertical = self.navigationOrientation == .vertical
                    self.currentPosition = CGPoint(x: isVertical ? 0.0 : CGFloat(rawIndex),
                                                   y: isVertical ? CGFloat(rawIndex) : 0.0)
                    self.currentIndex = rawIndex
                    
                    // if not animated call position delegate update manually
                    if !animated {
                        self.delegate?.pageboyViewController(self,
                                                             didScrollTo: self.currentPosition!,
                                                             direction: direction,
                                                             animated: animated)
                    }
                }
                
                self.autoScroller.didFinishScrollIfEnabled()
                completion?(viewController, animated, finished)
                self.isScrollingAnimated = false
            }
            
            updateViewControllers(to: [viewController],
                                  from: currentIndex ?? 0,
                                  to: rawIndex,
                                  direction: direction,
                                  animated: animated,
                                  completion: transitionCompletion)
            
            return true
            
        } else {
            guard let viewController = viewController(at: rawIndex) else { return false }
            self.autoScroller.didFinishScrollIfEnabled()
            completion?(viewController, animated, false)
            
            return false
        }
    }
    
    private var isUpdatingViewControllers: Bool = false
    internal func updateViewControllers(to viewControllers: [UIViewController],
                                       from fromIndex: PageIndex = 0,
                                       to toIndex: PageIndex = 0,
                                       direction: NavigationDirection = .forward,
                                       animated: Bool,
                                       completion: TransitionOperation.Completion?) {
        guard let pageViewController = self.pageViewController, !isUpdatingViewControllers else {
            return
        }
        
        targetIndex = toIndex
        isUpdatingViewControllers = true
        performTransition(from: fromIndex,
                          to: toIndex,
                          with: direction,
                          animated: animated,
                          completion: completion ?? { _ in })
        pageViewController.setViewControllers(viewControllers,
                                              direction: direction.pageViewControllerNavDirection,
                                              animated: false,
                                              completion:
            { (finished) in
                self.isUpdatingViewControllers = false
                
                if !animated {
                    completion?(finished)
                }
        })
    }
}
