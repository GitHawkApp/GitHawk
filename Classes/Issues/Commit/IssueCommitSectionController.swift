//
//  IssueCommitSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommitSectionController: ListGenericSectionController<IssueCommitModel>, IssueCommitCellDelegate {

    let owner: String
    let repo: String

    init(owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueCommitCell.self, for: self, at: index) as? IssueCommitCell,
            let object = self.object
            else { fatalError("Missing collection context, cell incorrect type, or object missing") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let hash = object?.hash else { return }
        viewController?.presentCommit(owner: owner, repo: repo, hash: hash)
    }

    // MARK: IssueCommitCellDelegate

    func didTapAvatar(cell: IssueCommitCell) {
        guard let login = object?.login else { return }
        viewController?.presentProfile(login: login)
    }

}
