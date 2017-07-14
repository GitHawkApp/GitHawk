//
//  IssueStatusEventSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueStatusEventSectionController: ListGenericSectionController<IssueStatusEventModel>, IssueStatusEventCellDelegate {

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
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueStatusEventCell.self, for: self, at: index) as? IssueStatusEventCell,
            let object = self.object
            else { fatalError("Cell incorrect type or object does not exist") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    // MARK: IssueStatusEventCellDelegate

    func didTapActor(cell: IssueStatusEventCell) {
        guard let actor = object?.actor else { return }
        viewController?.presentProfile(login: actor)
    }

    func didTapHash(cell: IssueStatusEventCell) {
        guard let hash = object?.commitHash else { return }
        viewController?.presentCommit(owner: owner, repo: repo, hash: hash)
    }

}

