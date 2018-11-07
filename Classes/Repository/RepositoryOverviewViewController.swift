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

class HackScrollIndicatorInsetsCollectionView: UICollectionView {
    override var scrollIndicatorInsets: UIEdgeInsets {
        set {
            super.scrollIndicatorInsets = UIEdgeInsets(top: newValue.top, left: 0, bottom: newValue.bottom, right: 0)
        }
        get { return super.scrollIndicatorInsets }
    }
}

class RepositoryOverviewViewController: BaseListViewController<NSString>,
BaseListViewControllerDataSource,
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

    override func fetch(page: NSString?) {
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

    // MARK: RepositoryBranchUpdatable

    func updateBranch(to newBranch: String) {
        guard self.branch != newBranch else { return }
        self.branch = newBranch
        fetch(page: nil)
    }

}
