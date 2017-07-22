//
//  SettingsSourceSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 22/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import SafariServices

final class SettingsSourceSectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: Styles.Sizes.tableSectionSpacing, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ButtonCell.self, for: self, at: index) as? ButtonCell
            else { fatalError("Collection context must be set or cell incorrect type") }
        cell.label.text = NSLocalizedString("Source Code", comment: "")
        cell.configure(disclosureHidden: false)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let url = URL(string: "https://github.com/rnystrom/Freetime/")
            else { fatalError("Should always create GitHub URL") }
        let safari = SFSafariViewController(url: url)
        viewController?.present(safari, animated: true)
    }
    
}

