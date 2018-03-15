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

class RepositoryOverviewViewController: BaseListViewController<NSString>,
BaseListViewControllerDataSource {

    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private var readme: RepositoryReadmeModel?

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load README.", comment: ""),
            dataSource: self
        )
        title = NSLocalizedString("Overview", comment: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackBarItemEmpty()
    }

    // MARK: Overrides

    override func fetch(page: NSString?) {
        let repo = self.repo
        let width = view.bounds.width

        client.githubClient.client
            .send(V3RepositoryReadmeRequest(owner: repo.owner, repo: repo.name)) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.global().async {
                    let options = GitHubMarkdownOptions(owner: repo.owner, repo: repo.name, flavors: [.baseURL])
                    let models = CreateCommentModels(markdown: response.data.content, width: width, options: options)
                    let model = RepositoryReadmeModel(models: models)
                    DispatchQueue.main.async { [weak self] in
                        self?.readme = model
                        self?.update(animated: trueUnlessReduceMotionEnabled)
                    }
                }
            case .failure:
                self?.error(animated: trueUnlessReduceMotionEnabled)
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        guard let readme = self.readme else { return [] }
        return [readme]
    }

    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController {
        return RepositoryReadmeSectionController()
    }

    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController {
        return RepositoryEmptyResultsSectionController(
            topInset: 0,
            layoutInsets: view.safeAreaInsets, 
            type: .readme
        )
    }

}
