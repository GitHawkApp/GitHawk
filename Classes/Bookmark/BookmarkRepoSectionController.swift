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
import SwipeCellKit

final class BookmarkRepoSectionController: ListSwiftSectionController<RepositoryDetails>, SwipeCollectionViewCellDelegate {

    private weak var delegate: BookmarkSectionControllerDelegate?

    init(delegate: BookmarkSectionControllerDelegate?) {
        self.delegate = delegate
    }

    override func createBinders(from value: RepositoryDetails) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(BookmarkRepoCell.self),
                size: {
                    return $0.collection.cellSize(with: Styles.Sizes.tableCellHeightLarge)
            }, configure: {
                $0.configure(owner: $1.value.owner, name: $1.value.name)
                $0.delegate = self
            }, didSelect: { [weak self] context in
                self?.viewController?.route(RepoRoute(
                    owner: context.value.owner,
                    repo: context.value.name,
                    branch: nil
                ))
            })
        ]
    }

    // MARK: SwipeCollectionViewCellDelegate

    func collectionView(_ collectionView: UICollectionView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let action = DeleteSwipeAction { _, _ in
            self.delegate?.didSwipeToDelete(at: indexPath)
        }

        return [action]
    }
}
