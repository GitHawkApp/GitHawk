//
//  IssueReferencedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedSectionController: ListGenericSectionController<IssueReferencedModel>, MarkdownStyledTextViewDelegate {

    private let client: GithubClient

    init(client: GithubClient) {
        self.client = client
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: object?.string.viewSize(in: collectionContext.safeContentWidth()).height ?? 0
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueReferencedCell.self, for: self, at: index) as? IssueReferencedCell,
        let object = self.object
            else { fatalError("Missing context, model, or cell wrong type") }
        cell.configure(object)
        cell.delegate = self
        return cell
    }

    private var shouldShowIssueOnItemSelection: Bool = true

    override func didSelectItem(at index: Int) {
        guard shouldShowIssueOnItemSelection else {
            shouldShowIssueOnItemSelection = true
            return
        }
        guard let object = self.object else { return }
        let model = IssueDetailsModel(owner: object.owner, repo: object.repo, number: object.number)
        viewController?.route_push(to: IssuesViewController(client: client, model: model))
    }

    // MARK: MarkdownStyledTextViewDelegate

    func didTap(cell: MarkdownStyledTextView, attribute: DetectedMarkdownAttribute) {
        guard let viewController = viewController else {
            return
        }
        shouldShowIssueOnItemSelection = !viewController.handle(attribute: attribute)
    }

}
