//
//  RepositoryOverviewViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import GitHubAPI
import Squawk

final class RepositoryOverviewViewController: BaseListViewController2<String>,
    BaseListViewController2DataSource,
    BaseListViewController2EmptyDataSource,
RepositoryBranchUpdatable {

    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private var readme: RepositoryReadmeModel?
    private var branch: String

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        self.branch = repo.defaultBranch
        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load README.", comment: "")
        )
        self.dataSource = self
        title = NSLocalizedString("Overview", comment: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        feed.collectionView.backgroundColor = .white
        makeBackBarItemEmpty()
    }

    // MARK: Overrides

    override func fetch(page: String?) {
        let repo = self.repo
        let width = view.bounds.width - Styles.Sizes.gutter * 2
        let contentSizeCategory = UIContentSizeCategory.preferred
        let branch = self.branch

        client.githubClient.client
            .send(V3RepositoryReadmeRequest(owner: repo.owner, repo: repo.name, branch: branch)) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.global().async {

                    let models = MarkdownModels(
                        response.data.content,
                        owner: repo.owner,
                        repo: repo.name,
                        width: width,
                        viewerCanUpdate: false,
                        contentSizeCategory: contentSizeCategory,
                        isRoot: false,
                        branch: branch
                    )
                    let model = RepositoryReadmeModel(models: models)
                    DispatchQueue.main.async { [weak self] in
                        self?.readme = model
                        self?.update(animated: trueUnlessReduceMotionEnabled)
                    }
                }
            case .failure(let error):
                Squawk.show(error: error)
                self?.error(animated: trueUnlessReduceMotionEnabled)
            }
        }
    }

    // MARK: BaseListViewController2DataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        guard let readme = self.readme else { return [] }
        return [ListSwiftPair.pair(readme) { RepositoryReadmeSectionController() }]
    }

    // MARK: BaseListViewController2EmptyDataSource

    func emptyModel(for adapter: ListSwiftAdapter) -> ListSwiftPair {
        let layoutInsets = view.safeAreaInsets
        return ListSwiftPair.pair("empty") {
            RepositoryEmptyResultsSectionController2(layoutInsets: layoutInsets, type: .readme)
        }
    }

    // MARK: RepositoryBranchUpdatable

    func updateBranch(to newBranch: String) {
        guard self.branch != newBranch else { return }
        self.branch = newBranch
        fetch(page: nil)
    }

}
