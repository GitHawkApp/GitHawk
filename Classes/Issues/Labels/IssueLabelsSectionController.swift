//
//  IssueLabelsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit


protocol IssueLabelTapSectionControllerDelegate: class {
    func didTapIssueLabel(owner: String, repo: String, label: String)
}

final class IssueLabelsSectionController: ListBindingSectionController<IssueLabelsModel>,
ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate {

    private let issue: IssueDetailsModel
    private var sizeCache = [String: CGSize]()
    private let lockedModel = Constants.Strings.locked
    private weak var tapDelegate: IssueLabelTapSectionControllerDelegate?

    init(issue: IssueDetailsModel, tapDelegate: IssueLabelTapSectionControllerDelegate) {
        self.issue = issue
        super.init()
        self.tapDelegate = tapDelegate
        minimumInteritemSpacing = Styles.Sizes.labelSpacing
        minimumLineSpacing = Styles.Sizes.labelSpacing
        let row = Styles.Sizes.rowSpacing
        inset = UIEdgeInsets(top: row, left: 0, bottom: row/2, right: 0)
        dataSource = self
        selectionDelegate = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = self.object else { return [] }
        var viewModels: [ListDiffable] = [object.status]
        if object.locked {
            viewModels.append(lockedModel as ListDiffable)
        }
        viewModels += object.labels as [ListDiffable]
        return viewModels
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {

        let key: String
        if let viewModel = viewModel as? RepositoryLabel {
            key = viewModel.name
        } else {
            if let viewModel = viewModel as? IssueLabelStatusModel {
                key = "status-\(viewModel.status.title)"
            } else {
                key = "locked-key"
            }
        }

        if let size = sizeCache[key] {
            return size
        }

        let size: CGSize
        if let viewModel = viewModel as? RepositoryLabel {
            size = LabelListCell.size(viewModel.name)
        } else {
            if let viewModel = viewModel as? IssueLabelStatusModel {
                size = IssueLabelStatusCell.size(viewModel.status.title)
            } else {
                size = IssueLabelStatusCell.size(lockedModel)
            }
        }
        sizeCache[key] = size
        return size
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        let cellType: AnyClass
        switch viewModel {
        case is RepositoryLabel: cellType = LabelListCell.self
        default: cellType = IssueLabelStatusCell.self
        }
        guard let cell = collectionContext?.dequeueReusableCell(of: cellType, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError("Missing context or wrong cell") }
        return cell
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        guard let viewModel = viewModel as? RepositoryLabel else { return }
        tapDelegate?.didTapIssueLabel(owner: issue.owner, repo: issue.repo, label: viewModel.name)
    }

}
