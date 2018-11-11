//
//  File+ListDiffable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension File: ListSwiftDiffable {

    var identifier: String {
        return filename + sha
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
