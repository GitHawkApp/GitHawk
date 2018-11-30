//
//  BookmarkIssueSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import GitHawkRoutes

final class BookmarkIssueSectionController: ListSwiftSectionController<BookmarkIssueViewModel> {

    override func createBinders(from value: BookmarkIssueViewModel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(BookmarkCell.self),
                size: {
                    return $0.collection.cellSize(with:
                        $0.value.text.viewSize(in: $0.collection.safeContentWidth()).height
                    )
            }, configure: {
                $0.configure(with: $1.value)
            }, didSelect: { [weak self] context in
                self?.viewController?.route(IssueRoute(
                    owner: context.value.repo.owner,
                    repo: context.value.repo.name,
                    number: context.value.number
                ))
            })
        ]
    }

}
