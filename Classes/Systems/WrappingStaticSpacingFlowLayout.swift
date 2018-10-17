//
//  WrappingStaticSpacingFlowLayout.swift
//  Freetime
//
//  Created by Joe Rocca on 12/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class WrappingStaticSpacingFlowLayout: UICollectionViewFlowLayout {

    var interitemSpacing: CGFloat {
        return minimumInteritemSpacing
    }

    var rowSpacing: CGFloat {
        return minimumLineSpacing
    }

    init(estimatedItemSize: CGSize = CGSize.zero, interitemSpacing: CGFloat, rowSpacing: CGFloat) {
        super.init()
        self.estimatedItemSize = estimatedItemSize
        self.minimumInteritemSpacing = interitemSpacing
        self.minimumLineSpacing = rowSpacing
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (index, attribute) in attributes.enumerated() {
                if index == 0 {
                    attribute.frame.origin.x = 0
                    continue
                }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = prevLayoutAttributes.frame.maxX
                if origin + interitemSpacing + attribute.frame.size.width < self.collectionViewContentSize.width {
                    attribute.frame.origin.x = origin + interitemSpacing
                }
            }
            return attributes
        }
        return nil
    }
}
