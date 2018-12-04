//
//  InboxDashboardSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class InboxDashboardSectionController: ListSwiftSectionController<InboxDashboardModel> {

    override func createBinders(from value: InboxDashboardModel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(InboxDashboardCell.self),
                size: {
                    return $0.collection.cellSize(with:
                        $0.value.text.viewSize(in: $0.collection.safeContentWidth()).height
                    )
            },
                configure: {
                    $0.configure(with: $1.value)
            })
        ]
    }

}
