//
//  InitialEmptyViewModel.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

struct InitialEmptyViewModel: ListSwiftDiffable {
    let imageName: String
    let title: String
    let description: String

    // MARK: ListDiffable

    var identifier: String {
        return imageName
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? InitialEmptyViewModel else { return false }
        return title == value.title
        && description == value.description
    }

}
