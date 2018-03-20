//
//  BookmarkSectionController.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import SwipeCellKit

protocol BookmarkSectionControllerDelegate: class {
    func didSelect(bookmarkSectionController: BookmarkSectionController, viewModel: BookmarkViewModel)
    func didDelete(bookmarkSectionController: BookmarkSectionController, viewModel: BookmarkViewModel)
}

final class BookmarkSectionController: ListGenericSectionController<BookmarkViewModel>, SwipeCollectionViewCellDelegate {

    weak var delegate: BookmarkSectionControllerDelegate?

    init(delegate: BookmarkSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width,
            let object = object else {
            fatalError("Missing context")
        }

        return CGSize(
            width: width,
            height: max(object.text.viewSize(width: width).height, Styles.Sizes.tableCellHeightLarge)
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BookmarkCell.self, for: self, at: index) as? BookmarkCell else {
            fatalError("Missing context or wrong cell type")
        }
        guard let object = object else { fatalError() }
        cell.delegate = self
        cell.configure(viewModel: object, height: sizeForItem(at: index).height)
        return cell
    }

    override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: trueUnlessReduceMotionEnabled)

        guard let object = object else { return }
        delegate?.didSelect(bookmarkSectionController: self, viewModel: object)
    }

    // MARK: SwipeCollectionViewCellDelegate

    func collectionView(_ collectionView: UICollectionView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let action = DeleteSwipeAction { [weak self] _, _ in
            guard let strongSelf = self, let object = strongSelf.object else { return }
            strongSelf.delegate?.didDelete(bookmarkSectionController: strongSelf, viewModel: object)
        }

        return [action]
    }

    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }

}
