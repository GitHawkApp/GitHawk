//
//  ViewController+Template.swift
//  Freetime
//
//  Created by Ehud Adler on 12/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubSession

extension NewIssueTableViewControllerDelegate where Self: UIViewController {

    private func _getTemplateIssueAlert(
        with templates: [IssueTemplate],
        session: GitHubUserSession?,
        repoDetails: IssueTemplateRepoDetails
        ) -> UIAlertController {

        let alertView = UIAlertController(
            title: Constants.Strings.newIssue,
            message: NSLocalizedString("Choose Template", comment: ""),
            preferredStyle: .actionSheet
        )

        for template in templates {
            alertView.addAction(
                UIAlertAction(
                    title: template.title,
                    style: .default,
                    handler: { _ in
                        guard let viewController = NewIssueTableViewController.create(
                            client: GithubClient(userSession: session),
                            owner: repoDetails.owner,
                            repo: repoDetails.name,
                            template: template.template,
                            signature: repoDetails.owner == Constants.GitHawk.owner ? .bugReport : .sentWithGitHawk
                            ) else {
                                assertionFailure("Failed to create NewIssueTableViewController")
                                return
                        }
                        viewController.delegate = self
                        let navController = UINavigationController(rootViewController: viewController)
                        navController.modalPresentationStyle = .formSheet
                        self.route_present(to: navController)
                }))
        }

        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Dismiss", comment: ""),
                style: .cancel,
                handler: { _ in
                    alertView.dismiss(animated: trueUnlessReduceMotionEnabled)
            })
        )
        return alertView
    }

    func getTemplateIssueAlert(
        withTemplates sortedTemplates: [IssueTemplate],
        session: GitHubUserSession? = nil,
        details: IssueTemplateRepoDetails
        ) -> UIAlertController {

        var templates = sortedTemplates
        templates.append(
            IssueTemplate(
                title: NSLocalizedString("Regular Issue", comment: ""),
                template: ""
            )
        )
        let alertView = _getTemplateIssueAlert(
            with: templates,
            session: session,
            repoDetails: details
        )
        return alertView
    }
}
