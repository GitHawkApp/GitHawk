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

struct IssueTemplateDetails {
    let owner: String
    let repo: String
    let session: GitHubUserSession?
    let viewController: UIViewController
    weak var delegate: NewIssueTableViewControllerDelegate?
}

enum IssueTemplateHelper {


    static private func matches(
        regex: String,
        text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let str = text as NSString
            let results = regex.matches(
                in: text,
                range: NSMakeRange(0, str.length))
            return results.map { str.substring(with: $0.range)}

        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    static func getNameAndDescription(fromTemplatefile file: String) -> (name: String?, about: String?) {
        let names = IssueTemplateHelper.matches(regex: "(?<=name:).*", text: file)
        let abouts = IssueTemplateHelper.matches(regex: "(?<=about:).*", text: file)
        let name = names.first?.trimmingCharacters(in: .whitespaces)
        let about = abouts.first?.trimmingCharacters(in: .whitespaces)
        return (name, about)
    }

    static func showIssueAlert(
        with templates: [IssueTemplate],
        details: IssueTemplateDetails) -> UIAlertController {

        let alertView = UIAlertController(
            title: NSLocalizedString("New Issue", comment: ""),
            message: NSLocalizedString("Choose Template", comment: ""),
            preferredStyle: .alert
        )

        for template in templates {
            alertView.addAction(
                UIAlertAction(
                    title: template.title,
                    style: .default,
                    handler: { _ in

                        guard let viewController = NewIssueTableViewController.createWithTemplate(
                            client: GithubClient(userSession: details.session),
                            owner: details.owner,
                            repo: details.repo,
                            template: template.template,
                            signature: template.title == "Bug Report" ? .bugReport : .sentWithGitHawk
                            ) else {
                                assertionFailure("Failed to create NewIssueTableViewController")
                                return
                        }
                        viewController.delegate = details.delegate
                        let navController = UINavigationController(rootViewController: viewController)
                        navController.modalPresentationStyle = .formSheet
                        details.viewController.present(navController, animated: trueUnlessReduceMotionEnabled)
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
            let alertView = IssueTemplateHelper.showIssueAlert(
                with: sortedTemplates,
                details: details
            )
            details.viewController.present(alertView, animated: trueUnlessReduceMotionEnabled)
        } else {
            // No templates exists, show blank new issue view controller
            guard let viewController = NewIssueTableViewController.create(
                client: GithubClient(userSession: details.session),
                owner: details.owner,
                repo: details.repo,
                signature: .sentWithGitHawk
                ) else {
                    assertionFailure("Failed to create NewIssueTableViewController")
                    return
            }
            viewController.delegate = details.delegate
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .formSheet
            details.viewController.present(navController, animated: trueUnlessReduceMotionEnabled)
        }
    }
}

extension GithubClient {

    private func fetchTemplateFile(
        owner: String,
        repo: String,
        filename: String,
        completion: @escaping (Result<String>) -> Void
        ) {

        self.fetchFile(
            owner: owner,
            repo: repo,
            branch: "master",
            path: ".github/ISSUE_TEMPLATE/\(filename)") { (result) in
                switch result {
                case .success(let file):
                    completion(.success(file))
                case .error(let error):
                    completion(.error(error))
                case .nonUTF8:
                    completion(.error(nil))
                }
        }
    }

    private func createTemplate(withOwner
        owner: String,
        repo: String,
        filename: String,
        completion: @escaping (Result<IssueTemplate>) -> Void
        ) {
        fetchTemplateFile(owner: owner, repo: repo, filename: filename) { (result) in
            switch result {
            case .success(let file):
                let nameAndDescription = IssueTemplateHelper.getNameAndDescription(fromTemplatefile: file)
                if let name = nameAndDescription.name {
                    completion(.success(IssueTemplate(title: name, template: file)))
                } else {
                    completion(.error(nil))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    func createNewIssue(
        owner: String,
        repo: String,
        session: GitHubUserSession?,
        mainViewController: UIViewController,
        delegate: NewIssueTableViewControllerDelegate) {

        var templates: [IssueTemplate] = []

        // Create group.
        // We need this since we will be making multiple async calls inside a for-loop.
        let templateGroup = DispatchGroup()

        let details = IssueTemplateDetails(
            owner: owner,
            repo: repo,
            session: session,
            viewController: mainViewController,
            delegate: delegate
        )

        self.fetchFiles(
            owner: owner,
            repo: repo,
            branch: "master",
            path: ".github/ISSUE_TEMPLATE") { (result) in
                switch result {
                case .success(let files):
                    for file in files {
                        templateGroup.enter()
                        self.createTemplate(withOwner: owner, repo: repo, filename: file.name, completion: {
                            switch $0 {
                            case .success(let template):
                                templates.append(template)
                            case .error(let error):
                                if let err = error {
                                    Squawk.show(error: err)
                                }
                            }
                            templateGroup.leave()
                        })
                    }
                case .error(let error):
                    Squawk.show(error: error)
                }

                // Wait for async calls in for-loop to finish up
                templateGroup.notify(queue: .main) {

                    // Sort lexicographically
                    let sortedTemplates = templates.sorted(by: {$0.title < $1.title })
                    IssueTemplateHelper.present(
                        withTemplates: sortedTemplates,
                        details: details
                    )
                }
        }
    }
}
