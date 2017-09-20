//
//  ColumnCardSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 20/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class ColumnCardSectionController: ListGenericSectionController<Project.Details.Column.Card> {
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: ceil(object?.title.textViewSize(width).height ?? 0)) // Need to add bottom label
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ColumnCardCell.self, for: self, at: index) as? ColumnCardCell,
            let object = self.object else {
                fatalError("Missing context, object, or cell is wrong type")
        }
        
        cell.configure(object)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        print("Tapped on card")
    }
    
}
