//
//  IssueManagingContextController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import ContextMenu
import GitHubAPI

final class IssueManagingContextController: NSObject, ContextMenuDelegate {

    // Int with lowers-highest permissions to do rank comparisons
    enum Permissions: Int {
        case none
        case author
        case collaborator
    }

    let manageButton: UIView

    private var _permissions: Permissions = .none {
        didSet {
            updateButtonVisibility()
        }
    }
    var permissions: Permissions {
        get { return _permissions }
        set (newValue) {
            // only allow setting to the higher permissions
            if newValue.rawValue > _permissions.rawValue {
                _permissions = newValue
            }
        }
    }
    let model: IssueDetailsModel
    var resultID: String? {
        didSet {
            guard let result = self.result else { return }
            if result.viewerCanUpdate {
                permissions = .author
            }
            updateButtonVisibility()
        }
    }
    let client: GithubClient
    weak var viewController: UIViewController?

    init(model: IssueDetailsModel, client: GithubClient) {
        let button = IssueManageButton()
        manageButton = button
        self.client = client
        self.model = model

        super.init()

        button.isHidden = true
        button.addTarget(self, action: #selector(onButton(sender:)), for: .touchUpInside)
    }

    var result: IssueResult? {
        guard let id = resultID else { return nil }
        return client.cache.get(id: id) as IssueResult?
    }

    func updateButtonVisibility() {
        manageButton.isHidden = actions.count == 0
    }

    enum Action {
        case labels
        case milestone
        case assignees
        case reviewers
        case unlock
        case lock
        case reopen
        case close
    }

    var actions: [Action] {
        if case .none = permissions { return [] }
        guard let result = self.result else { return [] }

        var actions = [Action]()

        if case .collaborator = permissions {
            actions += [ .labels, .milestone, .assignees ]
            if result.pullRequest {
                actions.append(.reviewers)
            }
            if result.labels.locked {
                actions.append(.unlock)
            } else {
                actions.append(.lock)
            }
        }

        switch result.labels.status.status {
        case .closed:
            actions.append(.reopen)
        case .open:
            actions.append(.close)
        case .merged: break
        }

        return actions
    }

    func item(_ action: Action) -> ContrastContextMenuItem {
        let title: String
        let iconName: String

        switch action {
        case .labels:
            title = Constants.Strings.labels
            iconName = "tag"
        case .milestone:
            title = Constants.Strings.milestone
            iconName = "milestone"
        case .assignees:
            title = Constants.Strings.assignees
            iconName = "person"
        case .reviewers:
            title = Constants.Strings.reviewers
            iconName = "reviewer"
        case .unlock:
            title =  Constants.Strings.unlock
            iconName = "key"
        case .lock:
            title = Constants.Strings.lock
            iconName = "lock"
        case .reopen:
            title = Constants.Strings.reopen
            iconName = "sync"
        case .close:
            title = Constants.Strings.close
            iconName = "x"
        }

        // Lock always has the divider above it assuming you're a collaborator.
        // If you aren't a collaborator (Lock does not show), close has the divider above it.
        let separator: Bool
        switch action {
        case .lock, .unlock: separator = true
        case .reopen, .close: separator = permissions != .collaborator
        default: separator = false
        }

        let iconColor: UIColor
        switch action {
        case .lock: iconColor = Styles.Colors.Gray.light.color
        case .close: iconColor = Styles.Colors.Red.medium.color
        case .reopen: iconColor = Styles.Colors.Green.medium.color
        default: iconColor = Styles.Colors.Blue.medium.color
        }

        return ContrastContextMenuItem(
            title: title,
            iconName: iconName,
            iconColor: iconColor,
            separator: separator,
            action: actionBlock(action)
        )

    }

    func actionBlock(_ action: Action) -> (ContrastContextMenu) -> Void {
        return { [weak self] menu in
            menu.dismiss(animated: true)
            guard let strongSelf = self else { return }
            switch action {
            case .labels: strongSelf.presentContextMenu(with: strongSelf.newLabelsController())
            case .milestone: strongSelf.presentContextMenu(with: strongSelf.newMilestonesController())
            case .assignees: strongSelf.presentContextMenu(with: strongSelf.newPeopleController(type: .assignee))
            case .reviewers: strongSelf.presentContextMenu(with: strongSelf.newPeopleController(type: .reviewer))
            case .unlock: strongSelf.lock(false)
            case .lock: strongSelf.lock(true)
            case .reopen: strongSelf.close(false)
            case .close: strongSelf.close(true)
            }
        }
    }

    @objc func onButton(sender: UIButton) {
        guard let viewController = self.viewController else { return }

        viewController.view.endEditing(true)
        let items = actions.map { self.item($0) }
        ContextMenu.shared.show(
            sourceViewController: viewController,
            viewController: ContrastContextMenu(items: items),
            options: ContextMenu.Options(
                containerStyle: ContextMenu.ContainerStyle(
                    xPadding: 0,
                    yPadding: 4,
                    backgroundColor: Styles.Colors.menuBackgroundColor.color
                ),
                menuStyle: .minimal,
                hapticsStyle: .medium
            ),
            sourceView: sender
        )
    }

    func newLabelsController() -> UIViewController {
        return LabelsViewController(
            selected: result?.labels.labels ?? [],
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
            selected: result?.milestone
        )
    }

    func newPeopleController(type: PeopleViewController.PeopleType) -> UIViewController {
        let result = self.result
        let selections: [String]
        let exclusions: [String]
        switch type {
        case .assignee:
            selections = result?.assignee.users.map { $0.login } ?? []
            exclusions = []
        case .reviewer:
            selections = result?.reviewers?.users.map { $0.login } ?? []
            if let isPullRequest = result?.pullRequest,
                let pullRequestAuthor = result?.rootComment?.details.login,
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

    func presentContextMenu(with controller: UIViewController) {
        guard let viewController = self.viewController else { return }
        ContextMenu.shared.show(
            sourceViewController: viewController,
            viewController: controller,
            options: ContextMenu.Options(
                containerStyle: ContextMenu.ContainerStyle(
                    backgroundColor: Styles.Colors.menuBackgroundColor.color
                )
            ),
            delegate: self
        )
    }

    func close(_ doClose: Bool) {
        guard let previous = result else { return }
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
        guard let previous = result else { return }
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
        guard let previous = result else { return }
        client.mutateLabels(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            labels: labels
        )
    }

    func didDismiss(controller: PeopleViewController) {
        guard let previous = result else { return }

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

    func didDismiss(controller: MilestonesViewController) {
        guard let previous = result else { return }
        client.setMilestone(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            milestone: controller.selected
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
