//
//  InitialEmptyViewSectionController.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class InitialEmptyViewSectionController: ListSwiftSectionController<InitialEmptyViewModel> {

    override func createBinders(from value: InitialEmptyViewModel) -> [ListBinder] {
        return [
            binder(value, cellType: ListCellType.class(InitialEmptyViewCell.self), size: {
                return $0.collection.insetContainerSize
            }, configure: {
                $0.configure(with: $1.value)
            })
        ]
    }

}
