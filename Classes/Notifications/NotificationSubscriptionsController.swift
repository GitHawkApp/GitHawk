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
        self.refreshSubscriptions()
    }

    // MARK: Public API

    var actions: [UIAlertAction] {
        switch state {
        case .loading: return []
        case .error: return [refreshAction]
        case .results(let repos): return repoActions(repos: repos)
        }
    }

    // MARK: Private API

    var refreshAction: UIAlertAction {
        return UIAlertAction(
            title: NSLocalizedString("Refresh", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.refreshSubscriptions()
        })
    }

    func repoActions(repos: [Repository]) -> [UIAlertAction] {
        return repos.map {
            let name = $0.name
            return UIAlertAction(title: name, style: .default, handler: { [weak self] _ in
                self?.pushRepoNotifications(name: name)
            })
        }
    }

    func pushRepoNotifications(name: String) {
        // TODO
    }

    func refreshSubscriptions() {
        client.fetchWatchedRepositories { [weak self] result in
            switch result {
            case .success(let repos): self?.state = .results(repos)
            case .error:
                self?.state = .error
                ToastManager.showGenericError()
            }
        }
    }

}
