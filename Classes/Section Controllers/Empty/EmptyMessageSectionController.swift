//
//  EmptyMessageSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class EmptyMessageSectionController: ListSwiftSectionController<String> {

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(value, cellType: ListCellType.class(LabelCell.self), size: {
                return $0.collection.insetContainerSize
            }, configure: {
                $0.label.text = $1.value
            })
        ]
    }

}
