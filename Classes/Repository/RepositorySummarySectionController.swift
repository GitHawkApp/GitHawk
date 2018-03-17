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
    private let repo: RepositoryDetails

    init(client: GithubClient, repo: RepositoryDetails) {
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
        
        let height = object.title.viewSize(width: width).height
            + Styles.Text.secondary.preferredFont.lineHeight
            + Styles.Sizes.rowSpacing
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
        let issueModel = IssueDetailsModel(owner: repo.owner, repo: repo.name, number: number)
        let controller = IssuesViewController(client: client, model: issueModel)
        viewController?.navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

}
