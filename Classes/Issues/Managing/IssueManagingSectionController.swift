//
//  IssueManagingSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueManagingSectionController: ListBindingSectionController<IssueManagingModel>,
ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate,
LabelsViewControllerDelegate,
MilestonesViewControllerDelegate,
PeopleViewControllerDelegate {

    private enum Action {
        static let labels = IssueManagingActionModel(
            label: NSLocalizedString("Labels", comment: ""),
            imageName: "tag",
            color: "3f88f7".color
        )
        static let milestone = IssueManagingActionModel(
            label: NSLocalizedString("Milestone", comment: ""),
            imageName: "milestone",
            color: "6847ba".color
        )
        static let assignees = IssueManagingActionModel(
            label: NSLocalizedString("Assignees", comment: ""),
            imageName: "person",
            color: "e77230".color
        )
        static let reviewers = IssueManagingActionModel(
            label: NSLocalizedString("Reviewers", comment: ""),
            imageName: "reviewer",
            color: "50a451".color
        )
        static let lock = IssueManagingActionModel(
            label: NSLocalizedString("Lock", comment: ""),
            imageName: "lock",
            color: Styles.Colors.Gray.dark.color
        )
        static let unlock = IssueManagingActionModel(
            label: NSLocalizedString("Unlock", comment: ""),
            imageName: "key",
            color: Styles.Colors.Gray.dark.color
        )
        static let reopen = IssueManagingActionModel(
            label: Constants.Strings.reopen,
            imageName: "sync",
            color: Styles.Colors.Green.medium.color
        )
        static let close = IssueManagingActionModel(
            label: Constants.Strings.close,
            imageName: "x",
            color: Styles.Colors.Red.medium.color
        )
    }

    private let model: IssueDetailsModel
    private let client: GithubClient
    private var expanded = false
    private var updating = false

    init(model: IssueDetailsModel, client: GithubClient) {
        self.model = model
        self.client = client
        super.init()
        selectionDelegate = self
        dataSource = self
    }

    // MARK: Private API

    var issueResult: IssueResult? {
        guard let id = object?.objectId else { return nil }
        return client.cache.get(id: id)
    }

    func newLabelsController() -> UIViewController {
        guard let controller = UIStoryboard(name: "Labels", bundle: nil).instantiateInitialViewController() as? LabelsViewController
            else { fatalError("Missing labels view controller") }
        controller.configure(
            selected: issueResult?.labels.labels ?? [],
            client: client,
            owner: model.owner,
            repo: model.repo,
            delegate: self
        )
        return controller
    }

    func newMilestonesController() -> UIViewController {
        guard let controller = UIStoryboard(name: "Milestones", bundle: nil).instantiateInitialViewController() as? MilestonesViewController
            else { fatalError("Missing milestones view controller") }
        controller.configure(
            client: client,
            owner: model.owner,
            repo: model.repo,
            selected: issueResult?.milestone,
            delegate: self
        )
        return controller
    }

    func newPeopleController(type: PeopleViewController.PeopleType) -> UIViewController {
        guard let controller = UIStoryboard(name: "People", bundle: nil).instantiateInitialViewController() as? PeopleViewController
            else { fatalError("Missing people view controller") }

        let selections: [String]
        switch type {
        case .assignee: selections = issueResult?.assignee.users.map { $0.login } ?? []
        case .reviewer: selections = issueResult?.reviewers?.users.map { $0.login } ?? []
        }

        controller.configure(
            selections: selections,
            type: type,
            client: client,
            delegate: self,
            owner: model.owner,
            repo: model.repo
        )
        return controller
    }

    func present(controller: UIViewController, from cell: UICollectionViewCell) {
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .popover
        nav.popoverPresentationController?.sourceView = cell
        nav.popoverPresentationController?.sourceRect = cell.bounds
        viewController?.present(nav, animated: trueUnlessReduceMotionEnabled)
    }

    func close(_ doClose: Bool) {
        guard let previous = issueResult else { return }

        client.setStatus(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            close: doClose
        )

        Haptic.triggerNotification(.success)
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = object as? IssueManagingModel,
            let result = issueResult
            else { fatalError("Object not correct type") }

        var models: [ListDiffable] = [IssueManagingExpansionModel(expanded: expanded)]
        if expanded {
            models += [
                Action.labels,
                Action.milestone,
                Action.assignees,
            ]
            if object.pullRequest {
                models.append(Action.reviewers)
            }
            switch result.status.status {
            case .closed: models.append(Action.reopen)
            case .open: models.append(Action.close)
            case .merged: break // can't do anything
            }
            if result.status.locked {
                models.append(Action.unlock)
            } else {
                models.append(Action.lock)
            }
        }
        return models
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let containerWidth = collectionContext?.containerSize.width
            else { fatalError("Collection context must be set") }
        switch viewModel {
        case is IssueManagingExpansionModel:
            let width = floor(containerWidth / 2)
            return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
        default:
            // justify-align cells to a max of 4-per-row
            let itemsPerRow = CGFloat(min(self.viewModels.count - 1, 4))
            let width = floor(containerWidth / itemsPerRow)
            return CGSize(
                width: width,
                height: IssueManagingActionCell.height
            )
        }
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        let cellClass: AnyClass
        switch viewModel {
        case is IssueManagingExpansionModel: cellClass = IssueManagingExpansionCell.self
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
        collectionContext?.deselectItem(at: index, sectionController: self, animated: trueUnlessReduceMotionEnabled)
        
        guard updating == false,
            let viewModel = viewModel as? ListDiffable,
            let cell = collectionContext?.cellForItem(at: index, sectionController: self)
            else { return }

        if let cell = cell as? IssueManagingExpansionCell {
            expanded = !expanded
            cell.animate(expanded: expanded)

            updating = true
            update(animated: trueUnlessReduceMotionEnabled, completion: { [weak self] _ in
                self?.updating = false
            })
        } else if viewModel === Action.labels {
            let controller = newLabelsController()
            present(controller: controller, from: cell)
        } else if viewModel === Action.milestone {
            let controller = newMilestonesController()
            present(controller: controller, from: cell)
        } else if viewModel === Action.assignees {
            let controller = newPeopleController(type: .assignee)
            present(controller: controller, from: cell)
        } else if viewModel === Action.reviewers {
            let controller = newPeopleController(type: .reviewer)
            present(controller: controller, from: cell)
        } else if viewModel === Action.close {
            close(true)
        } else if viewModel === Action.reopen {
            close(false)
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

    // MARK: MilestonesViewControllerDelegate

    func didDismiss(controller: MilestonesViewController, selected: Milestone?) {
        guard let previous = issueResult else { return }
        client.setMilestone(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            milestone: selected
        )
    }

    // MARK: PeopleViewControllerDelegate

    func didDismiss(
        controller: PeopleViewController,
        type: PeopleViewController.PeopleType,
        selections: [User]
        ) {
        guard let previous = issueResult else { return }
        var assignees = [IssueAssigneeViewModel]()
        for user in selections {
            guard let url = URL(string: user.avatar_url) else { continue }
            assignees.append(IssueAssigneeViewModel(login: user.login, avatarURL: url))
        }

        let mutationType: GithubClient.AddPeopleType
        switch type {
        case .assignee: mutationType = .assignee
        case .reviewer: mutationType = .reviewer
        }

        client.addPeople(
            type: mutationType,
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            people: assignees
        )
    }

}
