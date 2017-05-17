//
//  SettingsUserModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class SettingsUserModel {

    let name: String
    let selected: Bool

    init(
        name: String,
        selected: Bool
        ) {
        self.name = name
        self.selected = selected
    }

}

extension SettingsUserModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SettingsUserModel else { return false }
        return selected == object.selected
    }

}
