//
//  IssueAssigneesSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueAssigneesSectionController: ListBindingSectionController<IssueAssigneesModel>,
ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate {

    var expanded = false

    override init() {
        super.init()
        dataSource = self
        selectionDelegate = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = object as? IssueAssigneesModel else { fatalError("Wrong model object") }

        // dont show anything if there are no users
        guard object.users.count > 0 else { return [] }

        let title: String
        switch object.type {
        case .assigned: title = NSLocalizedString("Assignees:", comment: "")
        case .reviewRequested: title = NSLocalizedString("Reviewers:", comment: "")
        }
        let urls = object.users.map { $0.avatarURL }

        var viewModels: [ListDiffable] = [
            IssueAssigneeSummaryModel(title: title, urls: urls, expanded: expanded)
        ]

        if expanded {
            for user in object.users {
                viewModels.append(IssueAssigneeViewModel(login: user.login, avatarURL: user.avatarURL))
            }
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
        guard let context = collectionContext
            else { fatalError("Collection context must be set") }
        let cellClass: AnyClass
        switch viewModel {
        case is IssueAssigneeSummaryModel: cellClass = IssueAssigneeSummaryCell.self
        case is IssueAssigneeViewModel: cellClass = IssueAssigneeUserCell.self
        default: fatalError("Unsupported model \(viewModel)")
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
        if viewModel is IssueAssigneeSummaryModel {
            expanded = !expanded
            update(animated: trueUnlessReduceMotionEnabled)
        } else if let viewModel = viewModel as? IssueAssigneeViewModel {
            viewController?.presentProfile(login: viewModel.login)
        }
    }

}
