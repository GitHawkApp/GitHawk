//
//  NotificationSectionController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit
import GitHubAPI

final class NotificationSectionController2: ListSwiftSectionController<NotificationViewModel2>, NotificationCell2Delegate {

    private let modelController: NotificationModelController
    private let generator = UIImpactFeedbackGenerator()

    init(modelController: NotificationModelController) {
        self.modelController = modelController
        super.init()
    }

    override func createBinders(from value: NotificationViewModel2) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(NotificationCell2.self),
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

    func didTapRead(cell: NotificationCell2) {
        guard let id = value?.id else { return }
        generator.impactOccurred()
        modelController.markNotificationRead(id: id)
    }

    func didTapWatch(cell: NotificationCell2) {
        guard let value = self.value else { return }
        modelController.toggleWatch(notification: value)
    }

    func didTapMore(cell: NotificationCell2, sender: UIView) {
        guard let value = self.value else { return }
            let alert = UIAlertController.configured(preferredStyle: .actionSheet)
            alert.addActions([
                viewController?.action(owner: value.owner),
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

    private func showIssue(model: NotificationViewModel2) {
        if NotificationClient.readOnOpen() {
            modelController.markNotificationRead(id: model.id)
        }

        switch model.ident {
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

    private func showRelease(_ release: String, model: NotificationViewModel2) {
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
                    ToastManager.showGenericError()
                }
        }
    }

}
