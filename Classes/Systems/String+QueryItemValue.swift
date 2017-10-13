//
//  String+QueryItemValue.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension String {

    func valueForQuery(key: String) -> String? {
        guard let items = URLComponents(string: self)?.queryItems else { return nil }
        for item in items {
            if item.name == key {
                return item.value
            }
        }
        return nil
    }

}
