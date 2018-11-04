//
//  IssueFilesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import GitHubAPI

final class IssueFilesViewController: BaseListViewController2<Int>,
    BaseListViewController2DataSource,
    BaseListViewController2EmptyDataSource {

    private let model: IssueDetailsModel
    private let client: GithubClient
    private var files = [File]()
    private let feedRefresh = FeedRefresh()

    init(model: IssueDetailsModel, client: GithubClient, fileCount: Int) {
        self.model = model
        self.client = client
        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load changes.", comment: "")
        )
        self.dataSource = self
        self.emptyDataSource = self
        let titleFormat = NSLocalizedString("Files (%d)", comment: "")
        title = String(format: titleFormat, fileCount)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override func fetch(page: Int?) {
        client.client.send(V3PullRequestFilesRequest(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            page: page)
        ) { [weak self] result in
            switch result {
            case .success(let response):
                let files = response.data.map {
                    File(
                        status: $0.status,
                        changes: $0.changes as NSNumber,
                        filename: $0.filename,
                        additions: $0.additions as NSNumber,
                        deletions: $0.deletions as NSNumber,
                        sha: $0.sha,
                        patch: $0.patch
                    )
                }
                if page != nil {
                    self?.files += files
                } else {
                    self?.files = files
                }
                self?.update(page: response.next, animated: trueUnlessReduceMotionEnabled)
            case .failure:
                self?.error(animated: trueUnlessReduceMotionEnabled)
            }
        }
    }

    // MARK: BaseListViewController2DataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return files.map { ListSwiftPair.pair($0, { IssueFilesSectionController() }) }
    }

    // MARK: BaseListViewController2EmptyDataSource

    func emptyModel(for adapter: ListSwiftAdapter) -> ListSwiftPair {
        return ListSwiftPair.pair(NSLocalizedString("No changes found.", comment: ""), {
            EmptyMessageSectionController()
        })
    }

}
