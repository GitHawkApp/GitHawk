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
    let title:String
    let template:String
}

enum IssueTemplateHelper {

    static private func matchesForRegexInText(
        regex: String!,
        text: String!) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString

            let results = regex.matches(
                in: text,
                options: [],
                range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}

        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    static func getNameAndDescriptionFromTemplateFile(file: String) -> (name: String?, about: String?) {

        let names = IssueTemplateHelper.matchesForRegexInText(regex: "(?<=name:).*", text: file)
        let abouts = IssueTemplateHelper.matchesForRegexInText(regex: "(?<=about:).*", text: file)
        let name = names.count > 0
            ? names[0].trimmingCharacters(in: .whitespaces)
            : nil
        let about = abouts.count > 0
            ? abouts[0].trimmingCharacters(in: .whitespaces)
            : nil
        return (name, about)
    }

    static func showIssueAlert(
        with templates: [IssueTemplate],
        owner: String,
        repo: String,
        session: GitHubUserSession?,
        mainViewController: UIViewController,
        delegate: NewIssueTableViewControllerDelegate) {

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
                            client: GithubClient(userSession: session),
                            owner: owner,
                            repo: repo,
                            template: template.template,
                            signature: template.title == "Bug Report" ? .bugReport : .sentWithGitHawk
                            ) else {
                                Squawk.showGenericError()
                                return
                        }
                        viewController.delegate = delegate
                        let navController = UINavigationController(rootViewController: viewController)
                        navController.modalPresentationStyle = .formSheet
                        mainViewController.present(navController, animated: trueUnlessReduceMotionEnabled)
                }))
        }

        alertView.addAction(
            UIAlertAction(
                title: "Dismiss",
                style: UIAlertActionStyle.cancel,
                handler: { _ in
                    alertView.dismiss(animated: true, completion: nil)
            })
        )
        mainViewController.present(alertView, animated: true, completion: nil)
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

    private func createTemplateWith(
        owner: String,
        repo: String,
        filename: String,
        completion: @escaping (Result<IssueTemplate>) -> Void
        ) {
        fetchTemplateFile(owner: owner, repo: repo, filename: filename) { (result) in
            switch result {
            case .success(let file):
                let nameAndDescription = IssueTemplateHelper.getNameAndDescriptionFromTemplateFile(file: file)
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
        let templateGroup = DispatchGroup()

        self.fetchFiles(
            owner: owner,
            repo: repo,
            branch: "master",
            path: ".github/ISSUE_TEMPLATE") { (result) in
                switch result {
                case .success(let files):
                    for file in files {
                        templateGroup.enter()
                        self.createTemplateWith(owner: owner, repo: repo, filename: file.name, completion: {
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

                    if sortedTemplates.count > 0 {
                        // Templates exists...
                        IssueTemplateHelper.showIssueAlert(
                            with: sortedTemplates,
                            owner: owner,
                            repo: repo,
                            session: session,
                            mainViewController: mainViewController,
                            delegate: delegate
                        )
                    } else {
                        // No templates exists, show blank new issue view controller
                        guard let viewController = NewIssueTableViewController.create(
                            client: GithubClient(userSession: session),
                            owner: owner,
                            repo: repo,
                            signature: .sentWithGitHawk
                            ) else {
                                Squawk.showGenericError()
                                return
                        }
                        viewController.delegate = delegate
                        let navController = UINavigationController(rootViewController: viewController)
                        navController.modalPresentationStyle = .formSheet
                        mainViewController.present(navController, animated: trueUnlessReduceMotionEnabled)
                    }
                }
        }
    }
}
