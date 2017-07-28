//
//  SearchResultSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class SearchResultSectionController: ListGenericSectionController<SearchResult> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchResultCell.self, for: self, at: index) as? SearchResultCell,
              let object = object else {
            fatalError("Missing context, object, or cell is wrong type")
        }
        
        cell.configure(result: object)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        print("Load Repo")
    }
    
}
