//
//  SettingsSignoutSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SettingsSignoutSectionController: IGListSectionController {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return CGSize(width: context.containerSize.width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let cell = context.dequeueReusableCell(of: CenteredButtonCell.self, for: self, at: index) as? CenteredButtonCell
            else { return UICollectionViewCell() }
        cell.label.text = NSLocalizedString("Sign out", comment: "")
        cell.label.textColor = Styles.Colors.red
        cell.configure(topSeparatorHidden: false, bottomSeparatorHidden: false)
        return cell
    }

    override func didSelectItem(at index: Int) {

    }

}
