//
//  NotificationSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit
import GitHubAPI
import Squawk

final class NotificationSectionController: ListSwiftSectionController<NotificationViewModel>, NotificationCellDelegate {

    private let modelController: NotificationModelController
    private let generator = UIImpactFeedbackGenerator()

    init(modelController: NotificationModelController) {
        self.modelController = modelController
        super.init()
    }

    override func createBinders(from value: NotificationViewModel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(NotificationCell.self),
                size: {
                    let width = $0.collection.containerSize.width
                    return CGSize(
                        width: width,
                        height: $0.value.title.viewSize(in: width).height
                    )
            },
                configure: { [weak self] in
                    $0.configure(with: $1.value, delegate: self)
                },
                didSelect: { [weak self] context in
                    self?.showIssue(model: context.value)
            })
        ]
    }

    func didTapRead(cell: NotificationCell) {
        guard
            let id = value?.id,
            let model = modelController.githubClient.cache.get(id: id) as NotificationViewModel?,
            !model.read
        else {
            return
        }
        cell.animateRead()
        generator.impactOccurred()
        modelController.markNotificationRead(id: id)
    }

    func didTapWatch(cell: NotificationCell) {
        guard let value = self.value else { return }
        modelController.toggleWatch(notification: value)
    }

    func didTapMore(cell: NotificationCell, sender: UIView) {
        guard let value = self.value else { return }
            let alert = UIAlertController.configured(preferredStyle: .actionSheet)
            alert.addActions([
                viewController?.action(owner: value.owner, icon: #imageLiteral(resourceName: "organization")),
                viewController?.action(
                    owner: value.owner,
                    repo: value.repo,
                    branch: value.branch,
                    issuesEnabled: value.issuesEnabled,
                    client: modelController.githubClient
                ),
                AlertAction.cancel()
                ])
            alert.popoverPresentationController?.setSourceView(sender)
            viewController?.present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func showIssue(model: NotificationViewModel) {
        if NotificationModelController.readOnOpen {
            modelController.markNotificationRead(id: model.id)
        }

        switch model.number {
        case .hash(let hash):
            viewController?.presentCommit(owner: model.owner, repo: model.repo, hash: hash)
        case .number(let number):
            let controller = IssuesViewController(
                client: modelController.githubClient,
                model: IssueDetailsModel(owner: model.owner, repo: model.repo, number: number),
                scrollToBottom: true
            )
            let navigation = UINavigationController(rootViewController: controller)
            viewController?.showDetailViewController(navigation, sender: nil)
        case .release(let release):
            showRelease(release, model: model)
        }
    }

    private func showRelease(_ release: String, model: NotificationViewModel) {
        modelController.githubClient.client
            .send(V3ReleaseRequest(owner: model.owner, repo: model.repo, id: release)) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.viewController?.presentRelease(
                        owner: model.owner,
                        repo: model.repo,
                        release: response.data.tagName
                    )
                case .failure:
                    Squawk.showGenericError()
                }
        }
    }

}
