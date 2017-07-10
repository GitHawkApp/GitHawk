//
//  IssueMergedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueMergedSectionController: ListGenericSectionController<IssueMergedModel>, IssueMergedCellDelegate {

    private let owner: String
    private let repo: String

    init(owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
        super.init()
        inset = Styles.Sizes.listInsetTight
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueMergedCell.self, for: self, at: index) as? IssueMergedCell,
            let object = self.object
            else { fatalError("Missing context, object, or cell wrong type") }
        cell.configure(viewModel: object)
        cell.delegate = self
        return cell
    }

    // MARK: IssueMergedCellDelegate

    func didTapActor(cell: IssueMergedCell) {
        guard let actor = object?.actor else { return }
        viewController?.presentProfile(login: actor)
    }

    func didTapHash(cell: IssueMergedCell) {
        guard let hash = object?.commitHash else { return }
        viewController?.presentCommit(owner: owner, repo: repo, hash: hash)
    }

}
