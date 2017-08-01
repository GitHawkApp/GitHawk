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
    let topLayoutGuide: UILayoutSupport
    let type: EmptyResultsType
    
    init(topInset: CGFloat, topLayoutGuide: UILayoutSupport, type: EmptyResultsType) {
        self.topInset = topInset
        self.topLayoutGuide = topLayoutGuide
        self.type = type
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.containerSize else { fatalError("Missing context") }
        return CGSize(width: size.width, height: size.height - topInset - topLayoutGuide.length)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: RepositoryEmptyResultsCell.self, for: self, at: index) as? RepositoryEmptyResultsCell else {
                fatalError("Missing context, object, or cell is wrong type")
        }
        
        cell.type = type
        return cell
    }
    
}
