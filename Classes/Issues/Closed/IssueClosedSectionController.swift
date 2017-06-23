//
//  IssueClosedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueClosedSectionController: ListGenericSectionController<IssueClosedModel> {

    override init() {
        super.init()
        inset = Styles.Sizes.listInsetTight
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width, height: 30)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueClosedCell.self, for: self, at: index) as? IssueClosedCell,
        let object = self.object
            else { return UICollectionViewCell() }
        cell.configure(object)
        return cell
    }

}
