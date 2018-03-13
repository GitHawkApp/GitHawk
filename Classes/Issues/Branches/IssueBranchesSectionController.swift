//
//  IssueBranchesSectionController.swift
//  Freetime
//
//  Created by Yury Bogdanov on 13/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueBranchesSectionController: ListSectionController {
    
    var object: IssueBranchesModel?
    
    override func didUpdate(to object: Any) {
        guard let object = object as? IssueBranchesModel else { return }
        self.object = object
        let rowSpacing = Styles.Sizes.rowSpacing
        inset = UIEdgeInsets(
            top: rowSpacing,
            left: 0,
            bottom: rowSpacing / 2 + (object.trailingMetadata ? rowSpacing : 0),
            right: 0
        )
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.insetContainerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: self.object?.attributedString.textViewSize(width).height ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let object = self.object,
            let cell = collectionContext?.dequeueReusableCell(of: IssueBranchesCell.self, for: self, at: index) as? IssueBranchesCell
            else { fatalError("Collection context must be set, missing object, or cell incorrect type") }
        cell.set(attributedText: object.attributedString)
        return cell
    }
}
