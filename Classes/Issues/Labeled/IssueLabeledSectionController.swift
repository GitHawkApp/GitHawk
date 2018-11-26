//
//  IssueLabeledSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabeledSectionController: ListGenericSectionController<IssueLabeledModel>, MarkdownStyledTextViewDelegate {

    private let issueModel: IssueDetailsModel
    private weak var tapDelegate: IssueLabelTapSectionControllerDelegate?

    init(issueModel: IssueDetailsModel, tapDelegate: IssueLabelTapSectionControllerDelegate) {
        self.issueModel = issueModel
        self.tapDelegate = tapDelegate
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: object?.string.viewSize(in: collectionContext.safeContentWidth()).height ?? 0
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueLabeledCell.self, for: self, at: index) as? IssueLabeledCell,
            let object = self.object
            else { fatalError("Missing collection context, cell incorrect type, or object missing") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    func didTap(cell: MarkdownStyledTextView, attribute: DetectedMarkdownAttribute) {
        if case .label(let label) = attribute {
            tapDelegate?.didTapIssueLabel(owner: label.owner, repo: label.repo, label: label.label)
        } else {
            viewController?.handle(attribute: attribute)
        }
    }

}
