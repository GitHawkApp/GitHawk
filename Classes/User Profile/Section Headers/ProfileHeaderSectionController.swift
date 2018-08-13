//
//  HeaderSectionController.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit


class ProfileHeaderSectionController: ListSectionController {
    
    let height: CGFloat = 44
    var headerKey: ProfileHeaderKey?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width - inset.left - inset.right, height: height - inset.top - inset.bottom)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ProfileHeaderCell.self,
                                                                for: self, at: index) as? ProfileHeaderCell,
            let headerKey = self.headerKey else {
                return UICollectionViewCell()
        }
        cell.configure(title: headerKey.title)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let headerKey = object as? ProfileHeaderKey {
            self.headerKey = headerKey
        }
    }
}
