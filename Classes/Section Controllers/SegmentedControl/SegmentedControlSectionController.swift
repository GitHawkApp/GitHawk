//
//  SegmentedControlSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol SegmentedControlSectionControllerDelegate: class {
    func didChangeSelection(sectionController: SegmentedControlSectionController, selection: String)
}

final class SegmentedControlSectionController: IGListGenericSectionController<SegmentedControlModel>, SegmentedControlCellDelegate {

    weak var delegate: SegmentedControlSectionControllerDelegate? = nil

    private var selectedIndex: Int = 0

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        // 28 is the default height of UISegmentedControl
        let height = 28 + 2*Styles.Sizes.rowSpacing
        return CGSize(width: context.containerSize.width, height: height)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let object = object,
            let cell = collectionContext?.dequeueReusableCell(of: SegmentedControlCell.self, for: self, at: index) as? SegmentedControlCell
            else { return UICollectionViewCell() }
        cell.configure(items: object.items, selectedIndex: selectedIndex)
        cell.delegate = self
        return cell
    }

    // MARK: SegmentedControlCellDelegate

    func didChangeSelection(cell: SegmentedControlCell, index: Int) {
        selectedIndex = index
        delegate?.didChangeSelection(sectionController: self, selection: object?.items[index] ?? "")
    }
    
}
