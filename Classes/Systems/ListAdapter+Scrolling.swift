//
//  ListAdapter+Scrolling.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

extension ListAdapter {

    func scroll(to object: Any, padding: CGFloat) {
        guard let collectionView = self.collectionView,
            let sectionController = sectionController(for: object)
            else { return }

        let itemIndex = sectionController.numberOfItems() - 1
        let path = IndexPath(item: itemIndex, section: sectionController.section)

        guard let attributes = collectionView.layoutAttributesForItem(at: path) else { return }

        let paddedMaxY = min(attributes.frame.maxY + padding, collectionView.contentSize.height)
        let viewportHeight = collectionView.bounds.height

        // make sure not already at the top
        guard paddedMaxY > viewportHeight else { return }

        let offset = paddedMaxY - viewportHeight + collectionView.contentInset.bottom
        collectionView.setContentOffset(
            CGPoint(x: collectionView.contentOffset.x, y: offset),
            animated: trueUnlessReduceMotionEnabled
        )
    }

}
