//
//  UIViewController+PageboyExtras.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 18/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /// The parent PageboyViewController.
    /// Available from any direct child view controllers within a PageboyViewController.
    public var parentPageboyViewController: PageboyViewController? {
        return parent?.parent as? PageboyViewController
    }
}
