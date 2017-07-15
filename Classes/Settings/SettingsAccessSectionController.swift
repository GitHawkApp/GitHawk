//
//  SettingsReportSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import SafariServices

final class SettingsAccessSectionController: ListSectionController {

    override init() {
        super.init()
        inset = UIEdgeInsets(top: Styles.Sizes.tableSectionSpacing, left: 0, bottom: Styles.Sizes.tableSectionSpacing, right: 0)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ButtonCell.self, for: self, at: index) as? ButtonCell
            else { fatalError("Collection context must be set or cell incorrect type") }
        cell.label.text = NSLocalizedString("Review GitHub Access", comment: "")
        cell.configure(disclosureHidden: false)
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let url = URL(string: "https://github.com/settings/connections/applications/\(GithubAPI.clientID)")
            else { fatalError("Should always create GitHub issue URL") }
        let safari = SFSafariViewController(url: url)
        viewController?.present(safari, animated: true)
    }

}
