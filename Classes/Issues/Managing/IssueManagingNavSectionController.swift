//
//  IssueManagingNavSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol IssueManagingNavSectionControllerDelegate: class {
    func didSelect(managingNavController: IssueManagingNavSectionController)
}

final class IssueManagingNavSectionController: ListSectionController {

    private weak var delegate: IssueManagingNavSectionControllerDelegate?

    init(delegate: IssueManagingNavSectionControllerDelegate) {
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(
            width: floor(collectionContext.cellWidth() / 2),
            height: Styles.Sizes.labelEventHeight
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueManagingExpansionCell.self, for: self, at: index) as? IssueManagingExpansionCell
            else { fatalError("Cannot dequeue cell") }
        return cell
    }

    override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)
        delegate?.didSelect(managingNavController: self)
    }

}
