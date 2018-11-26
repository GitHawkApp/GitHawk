//
//  IssueRenamedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueRenamedSectionController: ListGenericSectionController<IssueRenamedModel>, IssueRenamedCellDelegate {

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: object?.titleChangeString.viewSize(in: collectionContext.safeContentWidth()).height ?? 0
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueRenamedCell.self, for: self, at: index) as? IssueRenamedCell,
            let object = self.object
            else { fatalError("Missing context, object, or cell wrong type") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    // MARK: IssueRenamedCellDelegate

    func didTapActor(cell: IssueRenamedCell) {
        guard let actor = object?.actor else { return }
        viewController?.presentProfile(login: actor)
    }

}
