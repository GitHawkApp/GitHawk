//
//  SearchBarSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol SearchBarSectionControllerDelegate: class {
    func didFinishSearching(term: String?)
    func didCancelSearching()
}

final class SearchBarSectionController: ListSectionController {

    weak var delegate: SearchBarSectionControllerDelegate? = nil
    
    init(delegate: SearchBarSectionControllerDelegate) {
        self.delegate = delegate
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchBarCell.self, for: self, at: index) as? SearchBarCell else {
            fatalError("Missing context, object, or cell is wrong type")
        }
        
        cell.delegate = delegate
        return cell
    }
    
}
