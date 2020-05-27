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
    func didChangeSegment(sectionController: SearchBarSectionController, index: Int)
}

final class SearchBarSectionController: ListSwiftSectionController<String>, SearchBarCellDelegate {

    public private(set) var query: String
    public private(set) var index: Int
    public private(set) var items: [String]?

    private weak var delegate: SearchBarSectionControllerDelegate?
    private let placeholder: String

    init(placeholder: String, delegate: SearchBarSectionControllerDelegate?, query: String = "", index: Int = 0, items: [String]? = nil) {
        self.delegate = delegate
        self.placeholder = placeholder
        self.query = query
        self.index = index
        self.items = items
        super.init()
    }

    override func createBinders(from value: String) -> [ListBinder] {

        if let items = items {
            return [
                binder(value, cellType: ListCellType.class(SearchSegmentBarCell.self), size: {
                    return $0.collection.cellSize(with: 56)
                }, configure: { [weak self] (cell, _) in
                    guard let `self` = self else { return }
                    cell.set(items: items)
                    cell.delegate = self
                    cell.configure(query: self.query, placeholder: self.placeholder)
                })
            ]
        }
        else {
            return [
                binder(value, cellType: ListCellType.class(SearchBarCell.self), size: {
                    return $0.collection.cellSize(with: 56)
                }, configure: { [weak self] (cell, _) in
                    guard let `self` = self else { return }
                    cell.delegate = self
                    cell.configure(query: self.query, placeholder: self.placeholder)
                })
            ]
        }
    }

    // MARK: SearchBarSectionControllerDelegate

    func didChangeSearchText(cell: SearchableCell, query: String) {
        self.query = query
        self.delegate?.didChangeSelection(sectionController: self, query: query)
    }

    func didChangeSegment(cell: SearchableCell, index: Int) {
        self.index = index
        self.delegate?.didChangeSegment(sectionController: self, index: index)
    }

}
