//
//  RepositorySummarySectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class RepositorySummarySectionController: ListGenericSectionController<RepositoryIssueSummaryModel> {

    private let client: GithubClient
    private let owner: String
    private let repo: String

    init(client: GithubClient, owner: String, repo: String) {
        self.owner = owner
        self.client = client
        self.repo = repo
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width,
            let object = object else {
                fatalError("Missing context or object")
        }

        let labelListViewHeightAndSpacing: CGFloat = {
            guard object.labels.count > 0 else { return 0 }
            let labelListViewWidth = width - (Styles.Sizes.columnSpacing * 2)
            let labelListViewHeight = LabelListView.height(width: labelListViewWidth,
                                                           labels: object.labels,
                                                           cacheKey: object.labelSummary)
            return labelListViewHeight + Styles.Sizes.rowSpacing
        }()

        let height = object.title.viewSize(in: width).height
            + Styles.Text.secondary.preferredFont.lineHeight
            + Styles.Sizes.gutter
            + labelListViewHeightAndSpacing
        return CGSize(width: width, height: ceil(height))
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: RepositorySummaryCell.self, for: self, at: index) as? RepositorySummaryCell,
            let object = self.object else {
                fatalError("Missing context, object, or cell is wrong type")
        }

        cell.configure(object)
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let number = self.object?.number else { return }
        let issueModel = IssueDetailsModel(owner: owner, repo: repo, number: number)
        let controller = IssuesViewController(client: client, model: issueModel)
        viewController?.view.endEditing(false) // resign keyboard if it was triggered to become active by SearchBar 
        viewController?.navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

}
