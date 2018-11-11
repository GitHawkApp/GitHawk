//
//  IssueMilestoneSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMilestoneSectionController: ListGenericSectionController<Milestone> {

    private let issueModel: IssueDetailsModel

    init(issueModel: IssueDetailsModel) {
        self.issueModel = issueModel
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: Styles.Text.secondary.preferredFont.lineHeight + Styles.Sizes.rowSpacing
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueMilestoneCell.self, for: self, at: index) as? IssueMilestoneCell,
            let object = self.object
            else { fatalError("Missing context, cell wrong type, or missing object") }
        cell.configure(milestone: object)
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let number = object?.number else { return }
        viewController?.presentMilestone(owner: issueModel.owner, repo: issueModel.repo, milestone: number)
    }

}
