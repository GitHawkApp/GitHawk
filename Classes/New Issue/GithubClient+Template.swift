//
//  GithubClient+Template.swift
//  Freetime
//
//  Created by Ehud Adler on 11/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI
import GitHubSession
import Squawk

extension GithubClient {

    private func fetchTemplateFile(
        repo: RepositoryDetails,
        filename: String,
        completion: @escaping (Result<String>) -> Void
        ) {

        self.fetchFile(
            owner: repo.owner,
            repo: repo.name,
            branch: repo.defaultBranch,
            path: "\(Constants.Filepaths.githubIssue)/\(filename)") { (result) in
                switch result {
                case .success(let file): completion(.success(file))
                case .error(let error):  completion(.error(error))
                case .nonUTF8:           completion(.error(nil))
                }
        }
    }

    private func createTemplate(
        repo: RepositoryDetails,
        filename: String,
        completion: @escaping (Result<IssueTemplate>) -> Void
        ) {
        fetchTemplateFile(repo: repo, filename: filename) { (result) in
            switch result {
            case .success(let file):
                let nameAndDescription = IssueTemplateHelper.getNameAndDescription(fromTemplatefile: file)
                if let name = nameAndDescription.name {
                    var cleanedFile = file

                    // Remove all template detail text
                    // -----
                    // name:
                    // about:
                    // -----
                    if let textToClean = file.matches(regex: Constants.Regex.Template.details).first {
                        if let range = file.range(of: textToClean) {
                            cleanedFile = file.replacingOccurrences(
                                of: textToClean,
                                with: "",
                                options: .literal,
                                range: range
                            )
                        }
                        cleanedFile = cleanedFile.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                    completion(.success(IssueTemplate(title: name, template: cleanedFile)))
                } else {
                    completion(.error(nil))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    func createNewIssue(
        repo: RepositoryDetails,
        session: GitHubUserSession?,
        mainViewController: UIViewController,
        delegate: NewIssueTableViewControllerDelegate,
        completion: @escaping () -> Void
        ) {

        var templates: [IssueTemplate] = []

        // Create group.
        // We need this since we will be making multiple async calls inside a for-loop.
        let templateGroup = DispatchGroup()

        let details = IssueTemplateDetails(
            repo: repo,
            session: session,
            viewController: mainViewController,
            delegate: delegate
        )

        self.fetchFiles(
            owner: repo.owner,
            repo: repo.name,
            branch: repo.defaultBranch,
            path: Constants.Filepaths.githubIssue) { (result) in
                switch result {
                case .success(let files):
                    for file in files {
                        templateGroup.enter()
                        self.createTemplate(repo: repo, filename: file.name, completion: { (result) in
                            switch result {
                            case .success(let template):
                                templates.append(template)
                            case .error(let error):
                                if let err = error { Squawk.show(error: err) }
                            }
                            templateGroup.leave()
                        })
                    }
                case .error(let error):
                    if let err = error { Squawk.show(error: err) }
                    completion()
                }

                // Wait for async calls in for-loop to finish up
                templateGroup.notify(queue: .main) {
                    completion()
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
