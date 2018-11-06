//
//  RepositoryFile.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class RepositoryFile: ListSwiftDiffable {

    let name: String
    let isDirectory: Bool

    init(name: String, isDirectory: Bool) {
        self.name = name
        self.isDirectory = isDirectory
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return name
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
