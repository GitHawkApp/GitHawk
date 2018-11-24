//
//  BookmarkMigrationSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class BookmarkMigrationSectionController: ListSwiftSectionController<String>,
BookmarkMigrationCellDelegate {

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(BookmarkMigrationCell.self),
                size: {
                    return CGSize(
                        width: $0.collection.insetContainerSize.width,
                        height: $0.collection.insetContainerSize.height
                    )
            },
                configure: { [weak self] (cell, _) in
                    cell.delegate = self
                })
        ]
    }

    // MARK: BookmarkMigrationCellDelegate

    func didTapMigrate(for cell: BookmarkMigrationCell) {

    }

}
