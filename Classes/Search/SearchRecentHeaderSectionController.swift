//
//  SearchRecentHeaderSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol SearchRecentHeaderSectionControllerDelegate: class {
    func didTapClear(sectionController: SearchRecentHeaderSectionController)
}

final class SearchRecentHeaderSectionController: ListSectionController, ClearAllHeaderCellDelegate {

    weak var delegate: SearchRecentHeaderSectionControllerDelegate?

    init(delegate: SearchRecentHeaderSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ClearAllHeaderCell.self, for: self, at: index) as? ClearAllHeaderCell
            else { fatalError("Missing context or wrong cell type") }
        cell.delegate = self
        cell.configure(title: NSLocalizedString("Recent Searches", comment: "").uppercased(with: Locale.current))
        return cell
    }

    // MARK: ClearAllHeaderCellDelegate

    func didSelectClear(cell: ClearAllHeaderCell) {
        delegate?.didTapClear(sectionController: self)
    }

}
