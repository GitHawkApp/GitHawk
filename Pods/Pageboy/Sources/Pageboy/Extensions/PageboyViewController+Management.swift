//
//  PageboyControllerManagement.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

// MARK: - VC Reloading
public extension PageboyViewController {
    
    /// Reload the view controllers in the page view controller.
    /// This reloads the dataSource entirely, calling viewControllers(forPageboyViewController:)
    /// and defaultPageIndex(forPageboyViewController:).
    public func reloadPages() {
        self.reloadPages(reloadViewControllers: true)
    }
    
    /// Reload the currently active page into the page view controller if possible.
    internal func reloadCurrentPageSoftly() {
        guard let currentIndex = self.currentIndex else { return }
        guard let currentViewController = viewController(at: currentIndex) else { return }
        
        self.pageViewController?.setViewControllers([currentViewController], direction: .forward,
                                                    animated: false, completion: nil)
    }
}

// MARK: - Paging Set Up and Configuration
internal extension PageboyViewController {
    
    // MARK: Set Up
    
    /// Set up inner UIPageViewController ready for displaying pages.
    ///
    /// - Parameter reloadViewControllers: Reload the view controllers data source for the PageboyViewController.
    internal func setUpPageViewController(reloadViewControllers: Bool = true) {
        var existingZIndex: Int?
        if self.pageViewController != nil { // destroy existing page VC
            existingZIndex = self.view.subviews.index(of: self.pageViewController!.view)
            self.pageViewController?.view.removeFromSuperview()
            self.pageViewController?.removeFromParentViewController()
            self.pageViewController = nil
        }
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: self.navigationOrientation,
                                                      options: self.pageViewControllerOptions)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        self.pageViewController = pageViewController
        
        self.addChildViewController(pageViewController)
      
        if let existingZIndex = existingZIndex {
            self.view.insertSubview(pageViewController.view, at: existingZIndex)
        } else {
            self.view.addSubview(pageViewController.view)
            self.view.sendSubview(toBack: pageViewController.view)
        }
      
        pageViewController.view.pinToSuperviewEdges()
      
        pageViewController.scrollView?.delegate = self
        pageViewController.view.backgroundColor = .clear
        pageViewController.scrollView?.delaysContentTouches = delaysContentTouches
        pageViewController.scrollView?.isScrollEnabled = isScrollEnabled
        pageViewController.scrollView?.isUserInteractionEnabled = isUserInteractionEnabled
        
        self.reloadPages(reloadViewControllers: reloadViewControllers)
    }
    
    /// Reload the pages in the PageboyViewController
    ///
    /// - Parameter reloadViewControllers: Reload the view controller data source.
    internal func reloadPages(reloadViewControllers: Bool) {
        
        if reloadViewControllers {
            viewControllerMap.clear()
        }
        
        let viewControllerCount = dataSource?.numberOfViewControllers(in: self) ?? 0
        self.viewControllerCount = viewControllerCount
        
        let defaultPage = self.dataSource?.defaultPage(for: self) ?? .first
        let defaultIndex = self.indexValue(for: defaultPage)
        
        guard defaultIndex < viewControllerCount,
            let viewController = viewController(at: defaultIndex) else {
                return
        }
        
        self.currentIndex = defaultIndex
        self.pageViewController?.setViewControllers([viewController],
                                                    direction: .forward,
                                                    animated: false,
                                                    completion: nil)
        
        self.delegate?.pageboyViewController(self,
                                             didReloadWith: viewController,
                                             currentPageIndex: defaultIndex)
    }
    
    internal func viewController(at index: PageIndex) -> UIViewController? {
        let viewController = dataSource?.viewController(for: self, at: index)
        if let viewController = viewController {
            let wrapper = WeakWrapper<UIViewController>(with: viewController)
            viewControllerMap.set(object: wrapper, for: index)
        }
        return viewController
    }
    
    /// Re-initialize the internal UIPageViewController instance without reloading data source if it currently exists.
    internal func reconfigurePageViewController() {
        guard self.pageViewController != nil else { return }
        self.setUpPageViewController(reloadViewControllers: false)
    }
    
    /// The options to be passed to a UIPageViewController instance.
    internal var pageViewControllerOptions: [String : Any]? {
        var options = [String : Any]()
        
        if self.interPageSpacing > 0.0 {
            options[UIPageViewControllerOptionInterPageSpacingKey] = self.interPageSpacing
        }
        
        guard options.count > 0 else {
            return nil
        }
        return options
    }
    
    // MARK: Utilities
    
    /// Convert a Page to a raw PageIndex.
    ///
    /// - Parameter pageIndex: The page index to translate.
    /// - Returns: The raw index integer.
    internal func indexValue(for page: Page) -> PageIndex {
        switch page {
            
        case .next:
            guard let currentIndex = self.currentIndex else {
                return 0
            }
            var proposedIndex = currentIndex + 1
            if self.isInfiniteScrollEnabled && proposedIndex == viewControllerCount { // scroll back to first index
                proposedIndex = 0
            }
            return proposedIndex
            
        case .previous:
            guard let currentIndex = self.currentIndex else {
                return 0
            }
            var proposedIndex = currentIndex - 1
            if self.isInfiniteScrollEnabled && proposedIndex < 0 { // scroll to last index
                proposedIndex = (viewControllerCount ?? 1) - 1
            }
            return proposedIndex
            
        case .first:
            return 0
            
        case .last:
            return (viewControllerCount ?? 1) - 1
            
        case .at(let index):
            return index
        }
    }
}

// MARK: - UIPageViewControllerDataSource, PageboyViewControllerDataSource
extension PageboyViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerCount = self.viewControllerCount else { return nil }

        if let index = self.currentIndex {
            if index != 0 {
                return self.viewController(at: index - 1)
            } else if self.isInfiniteScrollEnabled {
                return self.viewController(at: viewControllerCount - 1)
            }
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerCount = self.viewControllerCount else { return nil }
        
        if let index = self.currentIndex {
            if index != viewControllerCount - 1 {
                return self.viewController(at: index + 1)
            } else if self.isInfiniteScrollEnabled {
                return self.viewController(at: 0)
            }
        }
        return nil
    }
}
