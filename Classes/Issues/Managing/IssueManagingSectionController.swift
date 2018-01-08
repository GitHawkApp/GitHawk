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
    private var updating = false

    init(model: IssueDetailsModel, client: GithubClient) {
        self.model = model
        self.client = client
        super.init()
        inset = UIEdgeInsets(top: Styles.Sizes.gutter, left: 0, bottom: Styles.Sizes.gutter, right: 0)
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

    func lock(_ doLock: Bool) {
        guard let previous = issueResult else { return }

        client.setLocked(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            locked: doLock
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

        var models = [ListDiffable]()
        if object.role == .collaborator {
            models += [
                Action.labels,
                Action.milestone,
                Action.assignees,
            ]
            if object.pullRequest {
                models.append(Action.reviewers)
            }
            if result.status.locked {
                models.append(Action.unlock)
            } else {
                models.append(Action.lock)
            }
        }
        switch result.status.status {
        case .closed: models.append(Action.reopen)
        case .open: models.append(Action.close)
        case .merged: break // can't do anything
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

        let height = IssueManagingActionCell.height
        let width = HangingChadItemWidth(
            index: index,
            count: viewModels.count,
            containerWidth: containerWidth,
            desiredItemWidth: height
        )
        return CGSize(
            width: width,
            height: height
        )
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueManagingActionCell.self, for: self, at: index) as? IssueManagingActionCell
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

        if viewModel === Action.labels {
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
        } else if viewModel === Action.lock {
            lock(true)
        } else if viewModel === Action.unlock {
            lock(false)
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
