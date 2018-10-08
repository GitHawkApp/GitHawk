//
//  Routable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol Routable {
    static func from(params: [String: String]) -> Self?
    var encoded: [String: String] { get }
    static var path: String { get }
}

extension Routable {
    var encoded: [String: String] { return [:] }
}
