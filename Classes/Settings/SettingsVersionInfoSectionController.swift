//
//  SettingsVersionInfoSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 15/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SettingsVersionInfoSectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = .zero
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: LabelCell.self, for: self, at: index) as? LabelCell
            else { fatalError("Collection context must be set or cell incorrect type") }
        cell.label.text = Bundle.main.prettyVersionString
        return cell
    }
    
}
