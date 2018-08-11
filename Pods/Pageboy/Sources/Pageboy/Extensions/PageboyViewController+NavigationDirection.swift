//
//  PageboyViewController+NavigationDirection.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 23/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

// MARK: - Navigation direction detection
internal extension PageboyViewController.NavigationDirection {
    
    var pageViewControllerNavDirection: UIPageViewControllerNavigationDirection {
        switch self {
            
        case .reverse:
            return .reverse
            
        default:
            return .forward
        }
    }
    
    static func forPage(_ page: Int,
                        previousPage: Int) -> PageboyViewController.NavigationDirection {
        return self.forPosition(CGFloat(page), previous: CGFloat(previousPage))
    }
    
    static func forPosition(_ position: CGFloat,
                            previous previousPosition: CGFloat) -> PageboyViewController.NavigationDirection {
        if position == previousPosition {
            return .neutral
        }
        return  position > previousPosition ? .forward : .reverse
    }
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
