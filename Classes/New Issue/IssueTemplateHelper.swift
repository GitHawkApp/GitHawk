//
//  IssueTemplates.swift
//  Freetime
//
//  Created by Ehud Adler on 11/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI
import GitHubSession
import Squawk

struct IssueTemplate {
    let title: String
    let template: String
}

class IssueTemplateHelper {

    static func getNameAndDescription(fromTemplatefile file: String) -> (name: String?, about: String?) {
        let names = file.matches(regex: String.getRegexForLine(after: "name"))
        let abouts = file.matches(regex: String.getRegexForLine(after: "about"))
        let name = names.first?.trimmingCharacters(in: .whitespaces)
        let about = abouts.first?.trimmingCharacters(in: .whitespaces)
        return (name, about)
    }

    static func showIssueAlert(
        with templates: [IssueTemplate],
        details: IssueTemplateDetails) -> UIAlertController {

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
                            client: GithubClient(userSession: details.session),
                            owner: details.repoDetails.repo.owner,
                            repo: details.repoDetails.repo.name,
                            template: template.template,
                            signature: details.repoDetails.repo.owner == Constants.GitHawk.owner ? .bugReport : .sentWithGitHawk
                            ) else {
                                assertionFailure("Failed to create NewIssueTableViewController")
                                return
                        }
                        viewController.delegate = details.delegate
                        let navController = UINavigationController(rootViewController: viewController)
                        navController.modalPresentationStyle = .formSheet
                        details.viewController.route_present(to: navController)
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

    static func present(
        withTemplates sortedTemplates: [IssueTemplate],
        details: IssueTemplateDetails) {
        if sortedTemplates.count > 0 {
            // Templates exists...
            var templates = sortedTemplates
            templates.append(
                IssueTemplate(
                    title: NSLocalizedString("Regular Issue", comment: ""),
                    template: ""
                )
            )
            let alertView = IssueTemplateHelper.showIssueAlert(
                with: templates,
                details: details
            )
            details.viewController.route_present(to: alertView)
        } else {
            // No templates exists, show blank new issue view controller
            guard let viewController = NewIssueTableViewController.create(
                client: GithubClient(userSession: details.session),
                owner: details.repoDetails.repo.owner,
                repo: details.repoDetails.repo.name,
                signature: .sentWithGitHawk
                ) else {
                    assertionFailure("Failed to create NewIssueTableViewController")
                    return
            }
            viewController.delegate = details.delegate
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .formSheet
            details.viewController.route_present(to: navController)
        }
    }
}
