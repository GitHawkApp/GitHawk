//
//  RepositoryEmptyResultsSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 01/08/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class RepositoryEmptyResultsSectionController: ListSectionController {

    let topInset: CGFloat
    let layoutInsets: UIEdgeInsets
    let type: RepositoryEmptyResultsType

    init(topInset: CGFloat, layoutInsets: UIEdgeInsets, type: RepositoryEmptyResultsType) {
        self.topInset = topInset
        self.layoutInsets = layoutInsets
        self.type = type
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize else { fatalError("Missing context") }
        return CGSize(width: size.width, height: size.height - topInset - layoutInsets.top - layoutInsets.bottom)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: RepositoryEmptyResultsCell.self, for: self, at: index) as? RepositoryEmptyResultsCell else {
            fatalError("Missing context, object, or cell is wrong type")
        }

        cell.configure(type)
        return cell
    }

}
