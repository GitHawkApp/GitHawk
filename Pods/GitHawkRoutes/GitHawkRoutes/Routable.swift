//
//  Routable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public protocol Routable {
    static func from(params: [String: String]) -> Self?
    var encoded: [String: String] { get }
}

extension Routable {

    static var path: String {
        return String(describing: self)
    }

    public var encoded: [String: String] { return [:] }

}
