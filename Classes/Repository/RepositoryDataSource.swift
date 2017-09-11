//
//  RepositoryDataSource.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class RepositoryDataSource {

    static let readmeTitle = NSLocalizedString("Readme", comment: "")
    static let issuesTitle = NSLocalizedString("Issues", comment: "")
    static let pullRequestsTitle = NSLocalizedString("Pull Requests", comment: "")

    // mutated by SegmentedControlSectionController
    let selection: SegmentedControlModel
    let loadMore = "loadMore" as ListDiffable

    private var readmeModel: RepositoryReadmeModel? = nil
    private var issues = [RepositoryIssueSummaryModel]()
    private var pullRequests = [RepositoryIssueSummaryModel]()

    // public for paging
    private(set) var issuesNextPage: String?
    private(set) var pullRequestsNextPage: String?

    init(hasIssuesEnabled: Bool) {
        var items = [RepositoryDataSource.readmeTitle]
        if hasIssuesEnabled {
            items.append(RepositoryDataSource.issuesTitle)
        }
        items.append(RepositoryDataSource.pullRequestsTitle)
        selection = SegmentedControlModel(items: items)
    }

    // MARK: Public

    enum State {
        case readme
        case issues
        case pullRequests
    }

    var state: State {
        switch selection.items[selection.selectedIndex] {
        case RepositoryDataSource.readmeTitle: return .readme
        case RepositoryDataSource.issuesTitle: return .issues
        case RepositoryDataSource.pullRequestsTitle: return .pullRequests
        default: fatalError("Repository selection in unknown state")
        }
    }

    var selectionModels: [ListDiffable] {
        switch state {
        case .readme:
            if let model = readmeModel {
                return [model]
            }
            return []
        case .issues:
            var models: [ListDiffable] = issues
            if issuesNextPage != nil {
                models.append(loadMore)
            }
            return models
        case .pullRequests:
            var models: [ListDiffable] = pullRequests
            if pullRequestsNextPage != nil {
                models.append(loadMore)
            }
            return models
        }
    }

    func reset(
        issues: [RepositoryIssueSummaryModel],
        issuesNextPage: String?,
        pullRequests: [RepositoryIssueSummaryModel],
        pullRequestsNextPage: String?
        ) {
        self.issues = issues
        self.issuesNextPage = issuesNextPage
        self.pullRequests = pullRequests
        self.pullRequestsNextPage = pullRequestsNextPage
    }

    func setReadme(
        _ readme: String,
        width: CGFloat,
        completion: @escaping () -> ()
        ) {
        DispatchQueue.global().async {
            let models = CreateCommentModels(markdown: readme, width: width)
            let model = RepositoryReadmeModel(models: models)
            DispatchQueue.main.async {
                self.readmeModel = model
                completion()
            }
        }
    }

    func setPullRequests(_ pullRequests: [RepositoryIssueSummaryModel], page: String?) {
        self.pullRequests = pullRequests
        self.pullRequestsNextPage = page
    }

    func appendIssues(issues: [RepositoryIssueSummaryModel], page: String?) {
        self.issues += issues
        self.issuesNextPage = page
    }

    func appendPullRequests(pullRequests: [RepositoryIssueSummaryModel], page: String?) {
        self.pullRequests += pullRequests
        self.pullRequestsNextPage = page
    }

}
