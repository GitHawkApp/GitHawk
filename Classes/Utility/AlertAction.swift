//
//  AlertActions.swift
//  Freetime
//
//  Created by Ivan Magda on 25/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

typealias AlertActionBlock = (UIAlertAction) -> Void

// MARK: AlertActions -

struct AlertAction {

    // MARK: Properties

    let rootViewController: UIViewController?
    let title: String?
    let style: UIAlertActionStyle

    // MARK: Init

    init(_ builder: AlertActionBuilder) {
        rootViewController = builder.rootViewController
        title = builder.title
        style = builder.style ?? .default
    }

    // MARK: Public

    func get(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: self.title, style: self.style, handler: handler)
    }

    func share(_ items: [Any],
               activities: [UIActivity]?,
               buildActivityBlock: ((UIActivityViewController) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Share", comment: ""), style: .default) { _ in
            let activityController = UIActivityViewController(activityItems: items, applicationActivities: activities)
            buildActivityBlock?(activityController)
            self.rootViewController?.present(activityController, animated: true)
        }
    }

    func view(client: GithubClient, repo: RepositoryDetails) -> UIAlertAction {
        return UIAlertAction(title: String.localizedStringWithFormat("View %@", repo.name), style: .default) { _ in
            let repoViewController = RepositoryViewController(client: client, repo: repo)
            self.rootViewController?.show(repoViewController, sender: nil)
        }
    }

    func view(owner: String, url: URL) -> UIAlertAction {
        return UIAlertAction(title: String.localizedStringWithFormat("View @%@", owner), style: .default) { _ in
            self.rootViewController?.presentSafari(url: url)
        }
    }

    func newIssue(issueController: NewIssueTableViewController) -> UIAlertAction {
        return UIAlertAction(title: Constants.Strings.newIssue, style: .default) { _ in
            let nav = UINavigationController(rootViewController: issueController)
            nav.modalPresentationStyle = .formSheet
            self.rootViewController?.present(nav, animated: true)
        }
    }

    // MARK: Static

    static func cancel(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Constants.Strings.cancel, style: .cancel, handler: handler)
    }

    static func ok(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Constants.Strings.ok, style: .default, handler: handler)
    }

    static func no(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Constants.Strings.no, style: .cancel, handler: handler)
    }

    static func yes(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Constants.Strings.yes, style: .default, handler: handler)
    }

    static func goBack(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Go back", comment: ""), style: .cancel, handler: handler)
    }

    static func discard(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Discard", comment: ""), style: .destructive, handler: handler)
    }

    static func delete(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: handler)
    }

    static func toggleIssue(_ status: IssueStatus, handler: AlertActionBlock? = nil) -> UIAlertAction {
        let title = status == .open
            ? NSLocalizedString("Close", comment: "")
            : NSLocalizedString("Reopen", comment: "")
        
        return UIAlertAction(title: title, style: .destructive, handler: handler)
    }
    
    static func toggleLocked(_ locked: Bool, handler: AlertActionBlock? = nil) -> UIAlertAction {
        let title = locked
            ? NSLocalizedString("Unlock", comment: "")
            : NSLocalizedString("Lock", comment: "")

        return UIAlertAction(title: title, style: .destructive, handler: handler)
    }

    static func login(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Constants.Strings.signin, style: .default, handler: handler)
    }

    static func markAll(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Mark all Read", comment: ""), style: .destructive, handler: handler)
    }

    static func clearAll(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Constants.Strings.clearAll, style: .destructive, handler: handler)
    }

}
