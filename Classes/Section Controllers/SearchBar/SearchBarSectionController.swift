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

protocol SetSearchBarTextDelegate: class {
    func append(query: String)
}

final class SearchBarSectionController: ListSwiftSectionController<String>, SearchBarCellDelegate, SetSearchBarTextSectionControllerDelegate {
    
    public private(set) var query: String

    private weak var delegate: SearchBarSectionControllerDelegate?
    private let placeholder: String
    private weak var setSearchBarTextDelegate: SetSearchBarTextDelegate?

    init(placeholder: String, delegate: SearchBarSectionControllerDelegate?, query: String = "") {
        self.delegate = delegate
        self.placeholder = placeholder
        self.query = query
        super.init()
    }

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(value, cellType: ListCellType.class(SearchBarCell.self), size: {
                return CGSize(width: $0.collection.containerSize.width, height: 56)
            }, configure: { [weak self] (cell, _) in
                guard let `self` = self else { return }
                cell.delegate = self
                cell.configure(query: self.query, placeholder: self.placeholder)
                self.setSearchBarTextDelegate = cell 
            })
        ]
    }

    // MARK: SearchBarSectionControllerDelegate

    func didChangeSearchText(cell: SearchBarCell, query: String) {
        self.query = query
        self.delegate?.didChangeSelection(sectionController: self, query: query)
    }
    
    // MARK: SetSearchBarTextDelegate
    
    func append(query: String) {
        setSearchBarTextDelegate?.append(query: query)
    }
}
