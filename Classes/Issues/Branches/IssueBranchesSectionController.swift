//
//  IssueBranchesSectionController.swift
//  Freetime
//
//  Created by Yury Bogdanov on 13/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueTargetBranchSectionController: ListSectionController {
    
    var object: IssueTargetBranchModel?
    
    override func didUpdate(to object: Any) {
        guard let object = object as? IssueTargetBranchModel else { return }
        self.object = object
        inset = Styles.Sizes.issueInset(vertical: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.adjustedContainerSize(for: self).width
            else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: self.object?.targetBranchText.viewSize(in: width).height ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let object = self.object,
            let cell = collectionContext?.dequeueReusableCell(of: IssueTargetBranchCell.self, for: self, at: index) as? IssueTargetBranchCell
            else { fatalError("Collection context must be set, missing object, or cell incorrect type") }
        cell.set(renderer: object.targetBranchText)
        return cell
    }
}
