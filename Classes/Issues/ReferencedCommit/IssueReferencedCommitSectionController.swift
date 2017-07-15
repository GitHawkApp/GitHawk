//
//  IssueReferencedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedCommitSectionController: ListGenericSectionController<IssueReferencedCommitModel>, IssueReferencedCommitCellDelegate {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueReferencedCommitCell.self, for: self, at: index) as? IssueReferencedCommitCell,
        let object = self.object
            else { fatalError("Missing context, model, or cell wrong type") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    // MARK: IssueReferencedCommitCellDelegate

    func didTapHash(cell: IssueReferencedCommitCell) {
        guard let object = self.object else { return }
        viewController?.presentCommit(owner: object.owner, repo: object.repo, hash: object.hash)
    }

    func didTapActor(cell: IssueReferencedCommitCell) {
        guard let actor = object?.actor else { return }
        viewController?.presentProfile(login: actor)
    }

}
