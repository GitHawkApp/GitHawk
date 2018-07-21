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

    override init() {
        super.init()
        inset = Styles.Sizes.issueInset(vertical: 0)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize(for: self).width,
            let object = self.object
            else { fatalError("Missing context") }
        return CGSize(width: width, height: object.titleChangeString.viewSize(in: width).height)
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
