//
//  IssueMilestoneEventSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMilestoneEventSectionController: ListGenericSectionController<IssueMilestoneEventModel>, IssueMilestoneEventCellDelegate {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: MilestoneEventCell.self, for: self, at: index) as? MilestoneEventCell,
        let object = self.object
            else { fatalError("Missing context, object, or wrong cell type") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    // MARK: IssueMilestoneEventCellDelegate

    func didTapActor(cell: IssueMilestoneEventCell) {
        guard let actor = object.actor else { return }
        viewController?.presentProfile(login: actor)
    }

}
