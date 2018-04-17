//
//  SegmentedControlSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol SearchBarSectionControllerDelegate: class {
    func didChangeSelection(sectionController: SearchBarSectionController, query: String)
}

final class SearchBarSectionController: ListSectionController, SearchBarCellDelegate {

    public private(set) var query: String

    private weak var delegate: SearchBarSectionControllerDelegate?
    private let placeholder: String

    init(placeholder: String, delegate: SearchBarSectionControllerDelegate, query: String = "") {
        self.delegate = delegate
        self.placeholder = placeholder
        self.query = query
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { fatalError("Collection context must be set") }
        // hardcoded size of UISearchBar on iOS 11
        return CGSize(width: context.containerSize.width, height: 56)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchBarCell.self, for: self, at: index) as? SearchBarCell
            else { fatalError("Collection context must be set, missing object, or cell incorrect type") }
        cell.delegate = self
        cell.configure(query: query, placeholder: placeholder)
        return cell
    }

    // MARK: SearchBarSectionControllerDelegate

    func didChangeSearchText(cell: SearchBarCell, query: String) {
        self.query = query
        self.delegate?.didChangeSelection(sectionController: self, query: query)
    }
}
