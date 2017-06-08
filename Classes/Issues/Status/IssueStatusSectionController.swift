//
//  IssueStatusSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueStatusSectionController: IGListGenericSectionController<IssueStatusModel> {

    override init() {
        super.init()
        inset = Styles.Sizes.listInsetTight
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return CGSize(width: context.containerSize.width, height: 30)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueStatusCell.self, for: self, at: index) as? IssueStatusCell,
        let object = self.object
            else { return UICollectionViewCell() }
        cell.bindViewModel(object)
        return cell
    }

}
