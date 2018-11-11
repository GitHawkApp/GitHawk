//
//  IssueTitleSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueTitleSectionController: ListSectionController {

    var object: IssueTitleModel?

    override init() {
        super.init()
        inset = UIEdgeInsets(top: Styles.Sizes.rowSpacing, left: 0, bottom: 0, right: 0)
    }

    override func didUpdate(to object: Any) {
        guard let object = object as? IssueTitleModel else { return }
        self.object = object
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: object?.string.viewSize(in: collectionContext.safeContentWidth()).height ?? 0
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let object = self.object,
            let cell = collectionContext?.dequeueReusableCell(of: IssueTitleCell.self, for: self, at: index) as? IssueTitleCell
            else { fatalError("Collection context must be set, missing object, or cell incorrect type") }
        cell.set(renderer: object.string)
        return cell
    }

}
