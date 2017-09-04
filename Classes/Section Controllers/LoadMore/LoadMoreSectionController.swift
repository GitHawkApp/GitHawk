//
//  LoadMoreSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol LoadMoreSectionControllerDelegate: class {
    func didSelect(sectionController: LoadMoreSectionController)
}

final class LoadMoreSectionController: ListSectionController {

    private weak var delegate: LoadMoreSectionControllerDelegate? = nil
    
    init(delegate: LoadMoreSectionControllerDelegate) {
        self.delegate = delegate
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: LoadMoreCell.self, for: self, at: index) else {
            fatalError("Missing context, or cell is wrong type")
        }
        
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.didSelect(sectionController: self)
    }

}
