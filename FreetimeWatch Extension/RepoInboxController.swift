//
//  RepoInboxController.swift
//  FreetimeWatch Extension
//
//  Created by Ryan Nystrom on 4/27/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import WatchKit
import Foundation
import GitHubAPI
import DateAgo
import StringHelpers

final class RepoInboxController: WKInterfaceController {

    struct Context {
        let client: Client
        let repo: V3Repository
        let notifications: [V3Notification]
        let dataController: InboxDataController
    }
    
    @IBOutlet var table: WKInterfaceTable!
    private var context: Context?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        guard let context = context as? Context else { return }
        self.context = context

        setTitle(context.repo.name)

        reload()
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        // only handle selections on the "mark read" button
        guard rowIndex == 0, let context = self.context else { return }

        let repo = context.repo
        let dataController = context.dataController
        dataController.read(repository: repo)

        context.client.send(V3MarkRepositoryNotificationsRequest(
            owner: repo.owner.login,
            repo: repo.name
        )) { result in
            // will unwind the read even though the controller is pushed
            if case .failure = result {
                dataController.unread(repository: repo)
            }
        }

        pop()
    }

    // MARK: Private API

    func reload() {
        guard let context = self.context else { return }

        table.insertRows(at: IndexSet(integer: 0), withRowType: ReadAllRowController.rowControllerIdentifier)

        table.insertRows(at: IndexSet(integersIn: 1 ..< context.notifications.count + 1), withRowType: RepoInboxRowController.rowControllerIdentifier)
        for (i, n) in context.notifications.enumerated() {
            guard let row = table.rowController(at: i+1) as? RepoInboxRowController else { continue }
            row.titleLabel.setText(n.subject.title)
            row.dateLabel.setText(n.updatedAt.agoString(.short))

            let imageName: String
            switch n.subject.type {
            case .commit: imageName = "git-commit"
            case .invitation: imageName = "mail"
            case .issue: imageName = "issue-opened"
            case .pullRequest: imageName = "git-pull-request"
            case .release: imageName = "tag"
            case .repo: imageName = "repo"
            case .vulnerabilityAlert: imageName = "alert"
            }
            row.typeImage.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate))

            if let identifier = n.subject.identifier {
                let number: String
                switch identifier {
                case .hash(let h):
                    number = h.hashDisplay
                case .number(let num):
                    number = "#\(num)"
                case .release(let r):
                    number = r
                }
                row.numberLabel.setText(number)
            }
        }
    }

}
