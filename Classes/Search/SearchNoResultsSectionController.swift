//
//  SearchNoResultsSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class SearchNoResultsSectionController: ListSectionController {

    let topInset: CGFloat
    let layoutInsets: UIEdgeInsets

    init(topInset: CGFloat, layoutInsets: UIEdgeInsets) {
        self.topInset = topInset
        self.layoutInsets = layoutInsets
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize else { fatalError("Missing context") }
        return CGSize(width: size.width, height: size.height - topInset - layoutInsets.top - layoutInsets.bottom)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchNoResultsCell.self, for: self, at: index) else {
            fatalError("Missing context, or cell is wrong type")
        }

        return cell
    }

}
