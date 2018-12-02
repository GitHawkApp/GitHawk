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

private let githubIssueURL = ".github/ISSUE_TEMPLATE"

struct IssueTemplateRepoDetails {
    let owner: String
    let name: String
    let defaultBranch: String
}

extension GithubClient {

    private func fetchTemplateFile(
        repoDetails: IssueTemplateRepoDetails,
        filename: String,
        testingFile: String? = nil,
        completion: @escaping (Result<String>) -> Void
        ) {

        // For Testing.
        if let testingFile = testingFile { completion(.success(testingFile)) }

        self.fetchFile(
            owner: repoDetails.owner,
            repo: repoDetails.name,
            branch: repoDetails.defaultBranch,
            path: "\(githubIssueURL)/\(filename)") { (result) in
                switch result {
                case .success(let file): completion(.success(file))
                case .error(let error): completion(.error(error))
                case .nonUTF8: completion(.error(nil))
                }
        }
    }

    func createTemplate(
        repoDetails: IssueTemplateRepoDetails,
        filename: String,
        testingFile: String? = nil,
        completion: @escaping (Result<IssueTemplate>) -> Void
        ) {

        fetchTemplateFile(repoDetails: repoDetails, filename: filename, testingFile: testingFile) { result in
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
                    if let textToClean = file.matches(regex: "([-]{3,})([\\s\\S]*)([-]{3,})").first {
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
        repoDetails: IssueTemplateRepoDetails,
        completion: @escaping (Result<[IssueTemplate]>) -> Void
        ) {

        var templates: [IssueTemplate] = []

        // Create group.
        // We need this since we will be making multiple async calls inside a for-loop.
        let templateGroup = DispatchGroup()

        fetchFiles(
            owner: repoDetails.owner,
            repo: repoDetails.name,
            branch: repoDetails.defaultBranch,
            path: githubIssueURL) { result in
                switch result {
                case .success(let files):
                    for file in files {
                        templateGroup.enter()
                        self.createTemplate(repoDetails: repoDetails, filename: file.name, completion: { result in
                            switch result {
                            case .success(let template):
                                templates.append(template)
                            default: break
                                // If error creating template continue silently
                                // Worst case is no templates are found and a blank issue is shown
                            }
                            templateGroup.leave()
                        })
                    }
                case .error(let error):
                    completion(.error(error))
                }

                // Wait for async calls in for-loop to finish up
                templateGroup.notify(queue: .main) {

                    // Sort lexicographically
                    let sortedTemplates = templates.sorted(by: {$0.title < $1.title })
                    completion(.success(sortedTemplates))
                }
        }
    }
}
