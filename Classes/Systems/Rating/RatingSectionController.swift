//
//  RatingSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol RatingSectionControllerDelegate: class {
    func ratingNeedsDismiss(sectionController: RatingSectionController)
}

final class RatingSectionController: ListSectionController, RatingCellDelegate {

    private weak var delegate: RatingSectionControllerDelegate?

    init(delegate: RatingSectionControllerDelegate) {
        super.init()
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight * 3)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: RatingCell.self, for: self, at: index) as? RatingCell
            else { fatalError("Missing context") }
        cell.delegate = self
        return cell
    }

    override func didSelectItem(at index: Int) {
        RatingController.prompt(.inFeed)
        delegate?.ratingNeedsDismiss(sectionController: self)
    }

    // MARK: RatingCellDelegate

    func didTapDismiss(cell: RatingCell) {
        RatingController.prompted()
        delegate?.ratingNeedsDismiss(sectionController: self)
    }

}
