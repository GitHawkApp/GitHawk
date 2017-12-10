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

    var path: String {
        return components.joined(separator: FilePath.joiner)
    }

    var basePath: String? {
        let count = components.count
        guard count > 1 else { return nil }
        return components[0..<count-1].joined(separator: FilePath.joiner)
    }

    var current: String? {
        return components.last
    }

    var fileExtension: String? {
        return current?.components(separatedBy: ".").last
    }

    func appending(_ component: String) -> FilePath {
        return FilePath(components: components + [component])
    }

}
