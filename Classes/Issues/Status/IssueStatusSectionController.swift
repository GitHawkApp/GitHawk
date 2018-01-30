//
//  IssueStatusSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueStatusSectionController: ListGenericSectionController<IssueStatusModel> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.insetContainerSize.width
            else { fatalError("Collection context must be set") }
        return CGSize(width: floor(width / 2), height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueStatusCell.self, for: self, at: index) as? IssueStatusCell,
        let object = self.object
            else { fatalError("Collection context must be set, cell incorrect type, or missing object") }
        cell.bindViewModel(object)
        return cell
    }

}
