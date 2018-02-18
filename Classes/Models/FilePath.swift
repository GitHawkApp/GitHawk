//
//  FilePath.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct FilePath {

    static private let joiner = "/"

    let components: [String]

    var baseComponents: [String]? {
        let count = components.count
        guard count > 1 else { return nil }
        return Array(components[0..<count-1])
    }

    var path: String {
        return components.joined(separator: FilePath.joiner)
    }

    var basePath: String? {
        return baseComponents?.joined(separator: FilePath.joiner)
    }

    var current: String? {
        return components.last
    }

    var fileExtension: String? {
        let components = current?.components(separatedBy: ".") ?? []
        if components.count > 1 {
            return components.last
        } else {
            return nil
        }
    }

    func appending(_ component: String) -> FilePath {
        return FilePath(components: components + [component])
    }

}
