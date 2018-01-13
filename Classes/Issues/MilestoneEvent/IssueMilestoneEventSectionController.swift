//
//  IssueMilestoneEventSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMilestoneEventSectionController: ListGenericSectionController<IssueMilestoneEventModel> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.insetContainerSize.width,
            let object = self.object
            else { fatalError("Collection context must be set") }
        return CGSize(
            width: width,
            height: object.attributedText.textViewSize(width).height
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueMilestoneEventCell.self, for: self, at: index) as? IssueMilestoneEventCell,
        let object = self.object
            else { fatalError("Missing context, object, or wrong cell type") }
        cell.configure(object)
        cell.delegate = viewController
        return cell
    }

}
