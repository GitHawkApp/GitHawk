//
//  UINavigationController+Replace.swift
//  Freetime
//
//  Created by Sherlock, James on 16/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func replaceTopMostViewController(_ newViewController: UIViewController, animated: Bool) {
        var currentViewControllers = viewControllers
        currentViewControllers[viewControllers.count - 1] = newViewController
        setViewControllers(currentViewControllers, animated: animated)
    }
    
}
