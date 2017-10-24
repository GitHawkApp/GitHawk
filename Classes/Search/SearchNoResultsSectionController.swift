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
    let topLayoutGuide: UILayoutSupport
    let bottomLayoutGuide: UILayoutSupport

    init(topInset: CGFloat, topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        self.topInset = topInset
        self.topLayoutGuide = topLayoutGuide
        self.bottomLayoutGuide = bottomLayoutGuide
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize else { fatalError("Missing context") }
        return CGSize(width: size.width, height: size.height - topInset - topLayoutGuide.length - bottomLayoutGuide.length)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchNoResultsCell.self, for: self, at: index) else {
            fatalError("Missing context, or cell is wrong type")
        }

        return cell
    }

}
