//
//  Filterable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

// Add to models to filter them with search query strings
protocol Filterable {
    func match(query: String) -> Bool
}

func filtered<T>(array: [T], query: String) -> [T] {
    return array.filter({ (o) -> Bool in
        if let o = o as? Filterable {
            return o.match(query: query)
        } else {
            // if object isn't Filterable, always include it
            return true
        }
    })
}
