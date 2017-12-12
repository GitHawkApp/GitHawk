//
//  LabelListViewHeightCache.swift
//  Freetime
//
//  Created by Joe Rocca on 12/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class LabelListViewHeightCache {
    
    static let shared = LabelListViewHeightCache()
    
    private var cache = [String: CGFloat]()
    
    func store(height: CGFloat, forKey key: String) {
        cache[key] = height
    }
    
    func height(forKey key: String) -> CGFloat? {
        return cache[key]
    }
}
