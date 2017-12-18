//
//  NotificationSubscriptionsController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class NotificationSubscriptionsController {

    enum State {
        case loading
        case results([Repository])
        case error
    }

    private weak var viewController: UIViewController?
    private let client: NotificationClient
    private var state: State = .loading

    init(viewController: UIViewController, client: NotificationClient) {
        self.viewController = viewController
        self.client = client
    }

    // MARK: Public API

    var actions: [UIAlertAction] {
        switch state {
        case .loading: return []
        case .error: return [refreshAction]
        case .results(let repos): return repoActions(repos: repos)
        }
    }

    public func fetchSubscriptions() {
        client.fetchWatchedRepositories { [weak self] result in
            switch result {
            case .success(let repos): self?.state = .results(repos)
            case .error:
                self?.state = .error
                ToastManager.showGenericError()
            }
        }
    }

    // MARK: Private API

    var refreshAction: UIAlertAction {
        return UIAlertAction(
            title: NSLocalizedString("Refresh", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.fetchSubscriptions()
        })
    }

    func repoActions(repos: [Repository]) -> [UIAlertAction] {
        return repos.map {
            let repo = $0
            return UIAlertAction(title: repo.name, style: .default, handler: { [weak self] _ in
                self?.pushRepoNotifications(owner: repo.owner.login, name: repo.name)
            })
        }
    }

    func pushRepoNotifications(owner: String, name: String) {
        let controller = NotificationsViewController(client: client, inboxType: .repo(owner: owner, name: name))
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }

}
