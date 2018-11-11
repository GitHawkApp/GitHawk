//
//  PullRequestReviewReplySectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol PullRequestReviewReplySectionControllerDelegate: class {
    func didSelect(replySectionController: PullRequestReviewReplySectionController, reply: PullRequestReviewReplyModel)
}

final class PullRequestReviewReplySectionController: ListGenericSectionController<PullRequestReviewReplyModel> {

    private weak var delegate: PullRequestReviewReplySectionControllerDelegate?

    init(delegate: PullRequestReviewReplySectionControllerDelegate) {
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(with: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: PullRequestReviewReplyCell.self, for: self, at: index) as? PullRequestReviewReplyCell
            else { fatalError("Missing context or wrong cell") }
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let object = self.object else { return }
        delegate?.didSelect(replySectionController: self, reply: object)
    }

}
