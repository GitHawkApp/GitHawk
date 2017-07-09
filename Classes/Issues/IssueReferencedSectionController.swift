//
//  IssueReferencedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedSectionController: ListGenericSectionController<IssueReferencedModel> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueReferencedCell.self, for: self, at: index) as? IssueReferencedCell,
        let object = self.object
            else { fatalError("Missing context, model, or cell wrong type") }
        cell.configure(object)
        return cell
    }

    override func didSelectItem(at index: Int) {

    }

}
