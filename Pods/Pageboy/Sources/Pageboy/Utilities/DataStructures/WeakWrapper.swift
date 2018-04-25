//
//  WeakWrapper.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 18/07/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

internal class WeakWrapper<T: AnyObject> {
    
    private(set) weak var object: T?
    
    init(with object: T) {
        self.object = object
    }
}
