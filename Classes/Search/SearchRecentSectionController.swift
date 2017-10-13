//
//  SearchRecentSectionController.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol SearchRecentSectionControllerDelegate: class {
    func didSelect(recentSectionController: SearchRecentSectionController, text: String)
}

// bridge to NSString for NSObject conformance
final class SearchRecentSectionController: ListGenericSectionController<NSString> {

    weak var delegate: SearchRecentSectionControllerDelegate? = nil

    init(delegate: SearchRecentSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeightLarge)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchRecentCell.self, for: self, at: index) as? SearchRecentCell
            else { fatalError("Missing context or wrong cell type") }
        cell.configure(text)
        return cell
    }

    override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)
        delegate?.didSelect(recentSectionController: self, text: text)
    }

    // MARK: Private API

    var text: String {
        return (object ?? "") as String
    }

}
