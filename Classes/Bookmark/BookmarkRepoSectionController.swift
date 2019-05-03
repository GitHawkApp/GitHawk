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

protocol BookmarkSectionControllerDelegate: AnyObject {
    func didSwipeToDelete(at indexPath: IndexPath)
}

final class BookmarkRepoSectionController: ListSwiftSectionController<RepositoryDetails>, SwipeCollectionViewCellDelegate {

    private weak var delegate: BookmarkSectionControllerDelegate?

    init(delegate: BookmarkSectionControllerDelegate?) {
        self.delegate = delegate
    }

    override func createBinders(from value: RepositoryDetails) -> [ListBinder] {
        let createdBinder = binder(value,
                                   cellType: ListCellType.class(BookmarkRepoCell.self),
                                   size: {
            return $0.collection.cellSize(with: Styles.Sizes.tableCellHeightLarge)
        }, configure: { (cell, listSectionController) in
            cell.configure(owner: listSectionController.value.owner, name: listSectionController.value.name)
            cell.delegate = self
        }, didSelect: { [weak self] context in
            self?.viewController?.route(RepoRoute(owner: context.value.owner,
                                                  repo: context.value.name,
                                                  branch: nil))
        })

        return [createdBinder]
    }

    func collectionView(_ collectionView: UICollectionView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let action = DeleteSwipeAction { _, _ in
            self.delegate?.didSwipeToDelete(at: indexPath)
        }

        return [action]
    }
}
