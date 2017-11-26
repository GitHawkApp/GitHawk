//
//  IssueLabelsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueLabelsSectionController: ListBindingSectionController<IssueLabelsModel>,
    ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate {

    private var expanded = false
    private let issueModel: IssueDetailsModel
    private let client: GithubClient
    private var labelsOverride: [RepositoryLabel]?

    init(issueModel: IssueDetailsModel, client: GithubClient) {
        self.issueModel = issueModel
        self.client = client
        super.init()
        selectionDelegate = self
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        var viewModels = [ListDiffable]()

        // use override labels when available
        let labels = (labelsOverride ?? self.object?.labels ?? [])
        let colors = labels.map { UIColor.fromHex($0.color) }

        // avoid an empty summary cell
        if labels.count > 0 {
            viewModels.append(IssueLabelSummaryModel(colors: colors))
        }
        if expanded {
            viewModels += labels as [ListDiffable]
        }

        return viewModels
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        guard let context = self.collectionContext
            else { fatalError("Collection context must be set") }

        let cellClass: AnyClass
        switch viewModel {
        case is IssueLabelSummaryModel: cellClass = IssueLabelSummaryCell.self
        default: cellClass = IssueLabelCell.self
        }

        guard let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError("Cell not bindable") }
        return cell
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        didSelectItemAt index: Int,
        viewModel: Any
        ) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)
        expanded = !expanded
        update(animated: true)
    }

}
