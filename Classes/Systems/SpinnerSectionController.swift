//
//  SpinnerSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SpinnerSectionController: ListSectionController {

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(with: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SpinnerCell.self, for: self, at: index) as? SpinnerCell
            else { fatalError("Missing context or cell wrong type") }
        return cell
    }

}
