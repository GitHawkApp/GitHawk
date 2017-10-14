//
//  RepositoryOverviewViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class RepositoryOverviewViewController: UIViewController,
FeedDelegate,
ListAdapterDataSource {

    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private let repo: RepositoryDetails
    private let client: RepositoryClient

    enum State {
        case initial
        case readme(RepositoryReadmeModel)
        case error
    }
    private var state = State.initial

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Overview", comment: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        // set the frame in -viewDidLoad is required when working with TabMan
        feed.collectionView.frame = view.bounds

        if #available(iOS 11.0, *) {
            feed.collectionView.contentInsetAdjustmentBehavior = .never
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: feed.collectionView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: Private API

    func fetch() {
        let repo = self.repo
        let width = view.bounds.width
        let feed = self.feed

        client.fetchReadme { [weak self] result in
            switch result {
            case .error:
                self?.state = .error
                feed.finishLoading(dismissRefresh: true, animated: true)
            case .success(let readme):
                DispatchQueue.global().async {
                    let options = GitHubMarkdownOptions(owner: repo.owner, repo: repo.name, flavors: [.baseURL])
                    let models = CreateCommentModels(markdown: readme, width: width, options: options)
                    let model = RepositoryReadmeModel(models: models)
                    DispatchQueue.main.async { [weak self] in
                        self?.state = .readme(model)
                        feed.finishLoading(dismissRefresh: true, animated: true)
                    }
                }
            }
        }
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        fetch()
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        switch state {
        case .error: return ["empty" as ListDiffable]
        case .readme(let readme): return [readme]
        case .initial: return []
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is RepositoryReadmeModel: return RepositoryReadmeSectionController()
        default: return RepositoryEmptyResultsSectionController(
            topInset: 0,
            topLayoutGuide: topLayoutGuide,
            bottomLayoutGuide: bottomLayoutGuide,
            type: .readme
            )
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}
