//
//  IssueLabeledSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabeledSectionController: IGListGenericSectionController<IssueLabeledModel> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width, height: 30)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueLabeledCell.self, for: self, at: index) as? IssueLabeledCell,
        let object = self.object
            else { return UICollectionViewCell() }
        cell.configure(object)
        return cell
    }

}
