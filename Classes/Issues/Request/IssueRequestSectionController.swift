//
//  IssueRequestSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueRequestSectionController: ListGenericSectionController<IssueRequestModel>, IssueRequestCellDelegate {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueRequestCell.self, for: self, at: index) as? IssueRequestCell,
            let object = self.object
            else { fatalError("Missing collection context, cell incorrect type, or object missing") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    // MARK: IssueRequestCellDelegate

    func didTapActor(cell: IssueRequestCell) {
        guard let actor = object?.actor else { return }
        viewController?.presentProfile(login: actor)
    }

    func didTapUser(cell: IssueRequestCell) {
        guard let user = object?.actor else { return }
        viewController?.presentProfile(login: user)
    }

}
