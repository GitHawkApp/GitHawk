//
//  UINavigationItem+DisplayModeButton.swift
//  Freetime
//
//  Created by Rizwan on 31/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UINavigationItem {

    func configure(_ displayModeButton: UIBarButtonItem? ) {
        leftBarButtonItem = displayModeButton
        leftItemsSupplementBackButton = true
    }
    
}
