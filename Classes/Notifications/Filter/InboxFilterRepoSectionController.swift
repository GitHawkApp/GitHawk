//
//  InboxFilterRepoSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class InboxFilterRepoSectionController: ListSwiftSectionController<RepositoryDetails> {

    private let inboxFilterController: InboxFilterController

    init(inboxFilterController: InboxFilterController) {
        self.inboxFilterController = inboxFilterController
        super.init()
    }

    override func createBinders(from value: RepositoryDetails) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(BookmarkRepoCell.self),
                size: {
                    return $0.collection.cellSize(with: Styles.Sizes.tableCellHeight)
            }, configure: {
                $0.configure(
                    owner: $1.value.owner,
                    name: $1.value.name
                )
            })
        ]
    }

    /**
 , didSelect: { [weak self] context in
 self?.inboxFilterController.update(selection: context.value)
 }
 */
    
}
