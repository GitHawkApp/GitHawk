//
//  SpacerSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/26/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class SpacerSectionController: ListSectionController {

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: Styles.Sizes.tableCellHeight/2
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SpacerCell.self, for: self, at: index) else {
            fatalError()
        }
        return cell
    }

}
