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

    private let issueModel: IssueDetailsModel

    init(issueModel: IssueDetailsModel) {
        self.issueModel = issueModel
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(with: Styles.Sizes.labelEventHeight)
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
        viewController?.presentCommit(owner: issueModel.owner, repo: issueModel.repo, hash: hash)
    }

    // MARK: IssueCommitCellDelegate

    func didTapAvatar(cell: IssueCommitCell) {
        guard let login = object?.login else { return }
        viewController?.presentProfile(login: login)
    }

}
