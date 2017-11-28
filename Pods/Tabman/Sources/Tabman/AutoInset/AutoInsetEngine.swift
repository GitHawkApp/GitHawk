//
//  AutoInsetEngine.swift
//  Tabman
//
//  Created by Merrick Sapsford on 22/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

class AutoInsetEngine {
    
    // MARK: Properties
    
    private var viewControllerInsets: [Int : UIEdgeInsets] = [:]
    
    /// Whether auto-insetting is enabled.
    var isEnabled: Bool = true
    
    // MARK: Insetting
    
    func inset(_ childViewController: UIViewController?,
               requiredInsets: TabmanBar.Insets) {
     
        guard let childViewController = childViewController else { return }
        guard self.isEnabled else { return }
        
        if #available(iOS 11, *) {
            childViewController.additionalSafeAreaInsets = requiredInsets.barInsets
        }
        
        // if a scroll view is found in child VC subviews inset by the required content inset.
        for scrollView in childViewController.embeddedScrollViews {
            guard let scrollView = scrollView else { continue }
            guard !scrollView.isBeingInteracted else { continue }
            
            if #available(iOS 11.0, *) {
                scrollView.contentInsetAdjustmentBehavior = .never
            }
            
            let requiredContentInset = calculateActualRequiredContentInset(for: scrollView,
                                                                           from: requiredInsets)
            
            // ensure scroll view is either at top or full height before doing automatic insetting
            var isValidLayout = true
            checkIsNotEmbeddedViewController(childViewController, {
                if requiredContentInset.top > 0.0 {
                    isValidLayout = scrollView.frame.minY == 0.0
                }
                if requiredContentInset.bottom > 0.0 {
                    // TODO - Figure out a way to check whether bottom of scroll view goes underneath bar.
                }
            })
            
            guard isValidLayout else {
                continue
            }
            
            // dont update if we dont need to
            if scrollView.contentInset != requiredContentInset {
                
                scrollView.contentInset = requiredContentInset
                scrollView.scrollIndicatorInsets = requiredContentInset
                
                var contentOffset = scrollView.contentOffset
                contentOffset.y = -requiredContentInset.top
                scrollView.contentOffset = contentOffset
            }
        }
    }

    // MARK: Utility
    
    /// Check whether a view controller is not an 'embedded' view controller type (i.e. UITableViewController)
    ///
    /// - Parameters:
    ///   - viewController: The view controller.
    ///   - success: Execution if view controller is not embedded type.
    private func checkIsNotEmbeddedViewController(_ viewController: UIViewController, _ success: () -> Void) {
        if !(viewController is UITableViewController) && !(viewController is UICollectionViewController) {
            success()
        }
    }
    
    /// Calculate the actual inset values to use including any custom contentInset values.
    ///
    /// - Parameters:
    ///   - scrollView: Scroll view.
    ///   - requiredInsets: Required TabmanBar insets.
    /// - Returns: Actual contentInset values to use.
    private func calculateActualRequiredContentInset(for scrollView: UIScrollView,
                                                     from requiredInsets: TabmanBar.Insets) -> UIEdgeInsets {
        var requiredContentInset = requiredInsets.all
        let currentContentInset = self.viewControllerInsets[scrollView.hash] ?? .zero
        
        self.viewControllerInsets[scrollView.hash] = requiredContentInset
        
        // take account of custom top / bottom insets
        let topInset = scrollView.contentInset.top - currentContentInset.top
        if topInset != 0.0 {
            requiredContentInset.top += topInset
        }
        let bottomInset = scrollView.contentInset.bottom - currentContentInset.bottom
        if bottomInset != 0.0 {
            requiredContentInset.bottom += bottomInset
        }
        
        requiredContentInset.left = currentContentInset.left
        requiredContentInset.right = currentContentInset.right
        
        return requiredContentInset
    }
}

private extension UIViewController {
    
    var embeddedScrollViews: [UIScrollView?] {
        
        var scrollViews = [UIScrollView?]()
        if let tableViewController = self as? UITableViewController { // UITableViewController
            scrollViews.append(tableViewController.tableView)
        } else if let collectionViewController = self as? UICollectionViewController { // UICollectionViewController
            scrollViews.append(collectionViewController.collectionView)
        } else { // standard subview filtering
            let subviews = self.view.subviews
            scrollViews.append(contentsOf: subviews.map({ $0 as? UIScrollView }))
        }
        return scrollViews
    }
}
