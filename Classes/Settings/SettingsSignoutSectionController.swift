//
//  SettingsSignoutSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SettingsSignoutSectionController: ListSectionController {

    let sessionManager: GithubSessionManager

    init(sessionManager: GithubSessionManager) {
        self.sessionManager = sessionManager
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: Styles.Sizes.tableSectionSpacing, right: 0)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return CGSize(width: context.containerSize.width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let cell = context.dequeueReusableCell(of: CenteredButtonCell.self, for: self, at: index) as? CenteredButtonCell
            else { return UICollectionViewCell() }
        cell.label.text = Strings.signout
        cell.label.textColor = Styles.Colors.red.color
        cell.configure(topSeparatorHidden: false, bottomSeparatorHidden: false)
        return cell
    }

    override func didSelectItem(at index: Int) {
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)

        let signoutAction = UIAlertAction(title: Strings.signout, style: .destructive) { _ in
            self.signout()
        }

        let title = NSLocalizedString("Are you sure?", comment: "")
        let message = NSLocalizedString("All of your accounts will be logged out. Do you want to continue?", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(signoutAction)

        viewController?.present(alert, animated: true)
    }

    private func signout() {
        sessionManager.remove(sessionManager.allUserSessions)
    }

}
