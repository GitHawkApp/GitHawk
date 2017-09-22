//
//  PageboyViewController+Extras.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 17/05/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

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

// MARK: - NavigationDirection Descriptions
extension PageboyViewController.NavigationDirection: CustomStringConvertible {
    public var description: String {
        switch self {
        case .forward:
            return "Forward"
        case .reverse:
            return "Reverse"
        default:
            return "Neutral"
        }
    }
}

// MARK: - PageboyAutoScrollerHandler
extension PageboyViewController: PageboyAutoScrollerHandler {
    
    func autoScroller(didRequestAutoScroll autoScroller: PageboyAutoScroller, animated: Bool) {
        self.scrollToPage(.next, animated: animated)
    }
}
