//
//  IssueManagingSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueManagingSectionController: ListBindingSectionController<NSString>,
ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate,
LabelsViewControllerDelegate {

    private enum Action {
        static let labels = NSLocalizedString("Edit Labels", comment: "") as ListDiffable
    }

    private let id: String
    private let model: IssueDetailsModel
    private let client: GithubClient
    private var expanded = false

    init(id: String, model: IssueDetailsModel, client: GithubClient) {
        self.id = id
        self.model = model
        self.client = client
        super.init()
        selectionDelegate = self
        dataSource = self
    }

    // MARK: Private API

    var issueResult: IssueResult? {
        return client.cache.get(id: id)
    }

    func editLabels(cell: UICollectionViewCell) {
        guard let controller = UIStoryboard(name: "Labels", bundle: nil).instantiateInitialViewController() as? LabelsViewController
            else { fatalError("Missing labels view controller") }
        controller.configure(
            selected: issueResult?.labels.labels ?? [],
            client: client,
            owner: model.owner,
            repo: model.repo,
            delegate: self
        )
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .popover
        nav.popoverPresentationController?.sourceView = cell
        nav.popoverPresentationController?.sourceRect = cell.bounds
        viewController?.present(nav, animated: true)
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        return [IssueManagingModel(expanded: expanded)]
            + (expanded ? [
                    Action.labels
                    ] : [])
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
        let cellClass: AnyClass
        switch viewModel {
        case is IssueManagingModel: cellClass = IssueManagingExpansionCell.self
        default: cellClass = IssueManagingActionCell.self
        }
        guard let cell = collectionContext?.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError("Cell not bindable") }
        return cell
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        didSelectItemAt index: Int,
        viewModel: Any
        ) {
        guard let viewModel = viewModel as? ListDiffable,
            let cell = collectionContext?.cellForItem(at: index, sectionController: self)
            else { return }

        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)

        if let cell = cell as? IssueManagingExpansionCell {
            expanded = !expanded
            cell.animate(expanded: expanded)
            update(animated: true)
        } else if viewModel === Action.labels {
            editLabels(cell: cell)
        }
    }

    // MARK: LabelsViewControllerDelegate

    func didDismiss(controller: LabelsViewController, selectedLabels: [RepositoryLabel]) {
        guard let previous = issueResult else { return }
        client.mutateLabels(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            labels: selectedLabels
        )
    }

}
