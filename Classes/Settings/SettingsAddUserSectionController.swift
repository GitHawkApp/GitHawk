//
//  SettingsAddUserSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

func newAddUserSectionController() -> IGListSingleSectionController {
    let configureBlock = { (object: Any, cell: UICollectionViewCell) in
        guard let cell = cell as? CenteredButtonCell else { return }
        cell.label.text = NSLocalizedString("Add another account", comment: "")
    }
    let sizeBlock = { (object: Any, context: IGListCollectionContext?) -> CGSize in
        guard let context = context else { return .zero }
        return CGSize(width: context.containerSize.width, height: Styles.Sizes.tableCellHeight)
    }
    return IGListSingleSectionController(
        cellClass: CenteredButtonCell.self,
        configureBlock: configureBlock,
        sizeBlock: sizeBlock
    )
}
