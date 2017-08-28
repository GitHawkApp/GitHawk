//
//  IssueMilestoneSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMilestoneSectionController: ListGenericSectionController<IssueMilestoneModel> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueMilestoneCell.self, for: self, at: index) as? IssueMilestoneCell,
        let object = self.object
            else { fatalError("Missing context, cell wrong type, or missing object") }
        cell.configure(title: object.title)
        return cell
    }

    override func didSelectItem(at index: Int) {
        // push milestone safari VC
    }

}
