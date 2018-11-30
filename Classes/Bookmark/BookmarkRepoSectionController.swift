//
//  BookmarkRepoSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import GitHawkRoutes

final class BookmarkRepoSectionController: ListSwiftSectionController<RepositoryDetails> {

    override func createBinders(from value: RepositoryDetails) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(BookmarkRepoCell.self),
                size: {
                    return $0.collection.cellSize(with: Styles.Sizes.tableCellHeightLarge)
            }, configure: {
                $0.configure(owner: $1.value.owner, name: $1.value.name)
            }, didSelect: { [weak self] context in
                self?.viewController?.route(RepoRoute(
                    owner: context.value.owner,
                    repo: context.value.name,
                    branch: nil
                ))
            })
        ]
    }

}
