//
//  IssueReferencedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedCommitSectionController: ListGenericSectionController<IssueReferencedCommitModel> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.insetContainerSize.width,
            let object = self.object
            else { fatalError("Missing context") }
        return CGSize(
            width: width,
            height: object.string.viewSize(width: width).height
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueReferencedCommitCell.self, for: self, at: index) as? IssueReferencedCommitCell,
        let object = self.object
            else { fatalError("Missing context, model, or cell wrong type") }
        cell.configure(object)
        cell.delegate = viewController
        return cell
    }

}
