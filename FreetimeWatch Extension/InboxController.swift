//
//  InboxController.swift
//  FreetimeWatch Extension
//
//  Created by Ryan Nystrom on 4/24/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import WatchKit
import Foundation
import GitHubSession
import GitHubAPI

final class InboxController: WKInterfaceController,
WatchAppUserSessionSyncDelegate,
InboxDataControllerDelegate {

    @IBOutlet var table: WKInterfaceTable!
    private var client: Client?
    private var dataController = InboxDataController()
    private let watchAppSync = WatchAppUserSessionSync(userSession: nil)
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        dataController.delegate = self

        // start syncing sessions
        watchAppSync?.delegate = self
        watchAppSync?.start()

        reconfigure(userSession: watchAppSync?.lastSyncedUserSession)
    }

    // MARK: Overrides

    override func contextForSegue(
        withIdentifier segueIdentifier: String,
        in table: WKInterfaceTable,
        rowIndex: Int
        ) -> Any? {
        guard let client = self.client else { return nil }
        let selection = dataController.unreadNotifications[rowIndex]
        return RepoInboxController.Context(
            client: client,
            repo: selection.repo,
            notifications: selection.notifications,
            dataController: dataController
        )
    }

    // MARK: Private API

    private func reconfigure(userSession: GitHubUserSession?) {
        guard let userSession = userSession else {
            table.setNumberOfRows(1, withRowType: SignInRowController.rowControllerIdentifier)
            return
        }

        let networkingConfigs = userSession.networkingConfigs
        let config = ConfiguredNetworkers(
            token: networkingConfigs.token,
            useOauth: networkingConfigs.useOauth
        )
        client = Client(
            httpPerformer: config.alamofire,
            apollo: config.apollo,
            token: userSession.token
        )
        fetch()
    }

    @IBAction func fetch() {
        guard let client = self.client else { return }
        table.setNumberOfRows(1, withRowType: LoadingRowController.rowControllerIdentifier)

        client.send(V3NotificationRequest(all: false)) { [weak self] response in
            switch response {
            case .failure:
                self?.handleError()
            case .success(let result):
                self?.handleSuccess(notifications: result.data)
            }
        }
    }

    @IBAction func readAll() {
        dataController.readAll()
        reload()
        client?.send(V3MarkNotificationsRequest()) { [weak self] result in
            if case .failure = result {
                self?.dataController.unreadAll()
                self?.reload()
            }
        }
    }

    func handleError() {
        table.setNumberOfRows(1, withRowType: ErrorRowController.rowControllerIdentifier)
    }

    func handleSuccess(notifications: [V3Notification]) {
        dataController.supply(notifications: notifications)
    }

    func reload() {
        let unread = dataController.unreadNotifications
        guard unread.count > 0 else {
            table.setNumberOfRows(1, withRowType: EmptyRowController.rowControllerIdentifier)
            return
        }

        table.setNumberOfRows(unread.count, withRowType: InboxRowController.rowControllerIdentifier)
        for (i, group) in unread.enumerated() {
            guard let row = table.rowController(at: i) as? InboxRowController else {
                continue
            }
            row.repoLabel.setText(group.repo.name)
            row.ownerLabel.setText("@\(group.repo.owner.login)")
            row.numberLabel.setText("\(group.notifications.count)")
        }
    }

    // MARK: WatchAppUserSessionSyncDelegate

    func sync(_ sync: WatchAppUserSessionSync, didReceive userSession: GitHubUserSession) {
        reconfigure(userSession: userSession)
    }

    // MARK: InboxDataControllerDelegate

    func didUpdate(dataController: InboxDataController) {
        reload()
    }

}
