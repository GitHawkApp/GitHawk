//
//  IssueTitleSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueTitleSectionController: ListGenericSectionController<NSAttributedStringSizing> {

    override init() {
        super.init()
        inset = Styles.Sizes.listInsetTight
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext
            else { return .zero }
        return CGSize(width: context.containerSize.width, height: self.object?.textViewSize.height ?? 0)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let object = self.object,
            let cell = context.dequeueReusableCell(of: IssueTitleCell.self, for: self, at: index) as? IssueTitleCell
            else { return UICollectionViewCell() }
        cell.label.attributedText = object.attributedText
        return cell
    }
    
}
