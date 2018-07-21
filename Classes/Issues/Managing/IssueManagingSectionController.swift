//
//  IssueManagingSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import GitHubAPI
import ContextMenu

final class IssueManagingSectionController: ListBindingSectionController<IssueManagingModel>,
ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate,
ContextMenuDelegate {

    private enum Action {
        static let labels = IssueManagingActionModel(
            key: "tag",
            label: NSLocalizedString("Labels", comment: ""),
            imageName: "tag",
            color: "3f88f7".color
        )
        static let milestone = IssueManagingActionModel(
            key: "milestone",
            label: NSLocalizedString("Milestone", comment: ""),
            imageName: "milestone",
            color: "6847ba".color
        )
        static let assignees = IssueManagingActionModel(
            key: "person",
            label: NSLocalizedString("Assignees", comment: ""),
            imageName: "person",
            color: "e77230".color
        )
        static let reviewers = IssueManagingActionModel(
            key: "reviewer",
            label: NSLocalizedString("Reviewers", comment: ""),
            imageName: "reviewer",
            color: "50a451".color
        )
        static let lock = IssueManagingActionModel(
            key: "lock", // share key so lock/unlock just updates cell
            label: NSLocalizedString("Lock", comment: ""),
            imageName: "lock",
            color: Styles.Colors.Gray.dark.color
        )
        static let unlock = IssueManagingActionModel(
            key: "lock", // share key so lock/unlock just updates cell
            label: NSLocalizedString("Unlock", comment: ""),
            imageName: "key",
            color: Styles.Colors.Gray.dark.color
        )
        static let reopen = IssueManagingActionModel(
            key: "open", // share key so open/close just updates cell
            label: Constants.Strings.reopen,
            imageName: "sync",
            color: Styles.Colors.Green.medium.color
        )
        static let close = IssueManagingActionModel(
            key: "open", // share key so open/close just updates cell
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
        minimumInteritemSpacing = Styles.Sizes.rowSpacing
        minimumLineSpacing = Styles.Sizes.rowSpacing
        selectionDelegate = self
        dataSource = self
    }

    // MARK: Private API

    var issueResult: IssueResult? {
        guard let id = object?.objectId else { return nil }
        return client.cache.get(id: id)
    }

    func newLabelsController() -> UIViewController {
        return LabelsViewController(
            selected: issueResult?.labels.labels ?? [],
            client: client,
            owner: model.owner,
            repo: model.repo
        )
    }

    func newMilestonesController() -> UIViewController {
        return MilestonesViewController(
            client: client,
            owner: model.owner,
            repo: model.repo,
            selected: issueResult?.milestone
        )
    }

    func newPeopleController(type: PeopleViewController.PeopleType) -> UIViewController {
        let selections: [String]
        let exclusions: [String]
        switch type {
        case .assignee:
            selections = issueResult?.assignee.users.map { $0.login } ?? []
            exclusions = []
        case .reviewer:
            selections = issueResult?.reviewers?.users.map { $0.login } ?? []
            if let isPullRequest = issueResult?.pullRequest,
                let pullRequestAuthor = issueResult?.rootComment?.details.login,
                isPullRequest {
                exclusions = [pullRequestAuthor]
            } else {
                exclusions = []
            }
        }
        return PeopleViewController(
            selections: selections,
            exclusions: exclusions,
            type: type,
            client: client,
            owner: model.owner,
            repo: model.repo
        )
    }

    func present(controller: UIViewController, from cell: UICollectionViewCell) {
        guard let viewController = self.viewController else { return }
        ContextMenu.shared.show(
            sourceViewController: viewController,
            viewController: controller,
            options: ContextMenu.Options(menuStyle: .minimal),
            sourceView: cell,
            delegate: self
        )
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

    func didDismiss(selected labels: [RepositoryLabel]) {
        guard let previous = issueResult else { return }
        client.mutateLabels(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            labels: labels
        )
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
        guard let containerWidth = collectionContext?.containerSize(for: self).width
            else { fatalError("Collection context must be set") }

        let height = IssueManagingActionCell.height

        let rawRowCount = min(CGFloat(viewModels.count), floor(containerWidth / (height + minimumInteritemSpacing)))
        return CGSize(
            width: floor((containerWidth - (rawRowCount - 1) * minimumInteritemSpacing) / rawRowCount),
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
            present(controller: newLabelsController(), from: cell)
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

    // MARK: MilestonesViewControllerDelegate

    func didDismiss(controller: MilestonesViewController) {
        guard let previous = issueResult else { return }
        client.setMilestone(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            milestone: controller.selected
        )
    }

    // MARK: PeopleViewControllerDelegate

    func didDismiss(controller: PeopleViewController) {
        guard let previous = issueResult else { return }

        let mutationType: V3AddPeopleRequest.PeopleType
        switch controller.type {
        case .assignee: mutationType = .assignees
        case .reviewer: mutationType = .reviewers
        }

        client.addPeople(
            type: mutationType,
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            people: controller.selected
        )
    }

    // MARK: ContextMenuDelegate

    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool) {
        if let milestones = viewController as? MilestonesViewController {
            didDismiss(controller: milestones)
        } else if let people = viewController as? PeopleViewController {
            didDismiss(controller: people)
        } else if let labels = viewController as? LabelsViewController {
            didDismiss(selected: labels.selected)
        }
    }

    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool) {}

}
