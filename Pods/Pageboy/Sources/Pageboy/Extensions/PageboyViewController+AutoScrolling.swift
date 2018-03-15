//
//  PageboyViewController+AutoScrolling.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 17/05/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

// MARK: - PageboyAutoScrollerHandler
extension PageboyViewController: PageboyAutoScrollerHandler {
    
    func autoScroller(didRequestAutoScroll autoScroller: PageboyAutoScroller, animated: Bool) {
        self.scrollToPage(.next, animated: animated)
    }
}
