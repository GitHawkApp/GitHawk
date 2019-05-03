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
import SwipeCellKit

final class BookmarkIssueSectionController: ListSwiftSectionController<BookmarkIssueViewModel>, SwipeCollectionViewCellDelegate {

    private weak var delegate: BookmarkSectionControllerDelegate?

    init(delegate: BookmarkSectionControllerDelegate?) {
        self.delegate = delegate
    }

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
                $0.delegate = self
            }, didSelect: { [weak self] context in
                self?.viewController?.route(IssueRoute(
                    owner: context.value.repo.owner,
                    repo: context.value.repo.name,
                    number: context.value.number
                ))
            })
        ]
    }

    func collectionView(_ collectionView: UICollectionView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let action = DeleteSwipeAction { _, indexPath in
            self.delegate?.didSwipeToDelete(at: indexPath)
        }

        return [action]
    }
}
