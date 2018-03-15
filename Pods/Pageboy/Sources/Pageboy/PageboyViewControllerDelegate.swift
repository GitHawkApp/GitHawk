//
//  PageboyViewControllerDelegate.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 24/11/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public protocol PageboyViewControllerDelegate: class {
    
    /// The page view controller will begin scrolling to a new page.
    ///
    /// - Parameters:
    ///   - pageboyViewController: The Page view controller.
    ///   - index: The new page index.
    ///   - direction: The direction of the scroll.
    ///   - animation: Whether the scroll will be animated.
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               willScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool)
    
    /// The page view controller did scroll to an offset between pages.
    ///
    /// - Parameters:
    ///   - pageboyViewController: The Page view controller.
    ///   - position: The current relative page position.
    ///   - direction: The direction of the scroll.
    ///   - animated: Whether the scroll is being animated.
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollTo position: CGPoint,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool)
    
    /// The page view controller did complete scroll to a new page.
    ///
    /// - Parameters:
    ///   - pageboyViewController: The Page view controller.
    ///   - index: The new page index.
    ///   - direction: The direction of the scroll.
    ///   - animation: Whether the scroll was animated.
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool)
    
    /// The page view controller did reload.
    ///
    /// - Parameters:
    ///   - pageboyViewController: The Pageboy view controller.
    ///   - currentViewController: The current view controller.
    ///   - currentPageIndex: The current page index.
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didReloadWith currentViewController: UIViewController,
                               currentPageIndex: PageboyViewController.PageIndex)
}

// MARK: - PageboyViewControllerDelegate default implementations
public extension PageboyViewControllerDelegate {
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               willScrollToPageAt index: Int,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {}
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollTo position: CGPoint,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {}
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPageAt index: Int,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {}
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didReloadWith currentViewController: UIViewController,
                               currentPageIndex: PageboyViewController.PageIndex){}
}
