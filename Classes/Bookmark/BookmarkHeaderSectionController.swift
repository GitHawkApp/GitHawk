//
//  BookmarkHeaderSectionController.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol BookmarkHeaderSectionControllerDelegate: class {
    func didTapClear(sectionController: BookmarkHeaderSectionController)
}

final class BookmarkHeaderSectionController: ListSectionController {

    weak var delegate: BookmarkHeaderSectionControllerDelegate?

    init(delegate: BookmarkHeaderSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ClearAllHeaderCell.self, for: self, at: index) as? ClearAllHeaderCell else {
            fatalError("Missing context or wrong cell type")
        }
        cell.delegate = self
        cell.configure(title: Constants.Strings.bookmarks.uppercased(with: Locale.current))
        return cell
    }

}

// MARK: ClearAllHeaderCellDelegate

extension BookmarkHeaderSectionController: ClearAllHeaderCellDelegate {
    func didSelectClear(cell: ClearAllHeaderCell) {
        delegate?.didTapClear(sectionController: self)
    }
}
