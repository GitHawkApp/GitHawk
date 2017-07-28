//
//  SearchLoadMoreSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol SearchLoadMoreSectionControllerDelegate: class {
    func didSelect(sectionController: SearchLoadMoreSectionController)
}

final class SearchLoadMoreSectionController: ListSectionController {

    weak var delegate: SearchLoadMoreSectionControllerDelegate? = nil
    
    init(delegate: SearchLoadMoreSectionControllerDelegate) {
        self.delegate = delegate
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchLoadMoreCell.self, for: self, at: index) else {
            fatalError("Missing context, object, or cell is wrong type")
        }
        
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.didSelect(sectionController: self)
    }
}
