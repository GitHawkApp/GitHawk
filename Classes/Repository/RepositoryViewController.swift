//
//  RepositoryViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import TUSafariActivity
import SafariServices

struct RepositoryDetails {
    let owner: String
    let name: String
    let hasIssuesEnabled: Bool
}

class RepositoryViewController: UIViewController,
    FeedDelegate,
    ListAdapterDataSource,
    SegmentedControlSectionControllerDelegate,
    LoadMoreSectionControllerDelegate,
PrimaryViewController {

    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()

    private let noReadmeResultsKey = "noReadmeResultsKey" as ListDiffable
    private let noIssuesResultsKey = "noIssuesResultsKey" as ListDiffable
    private let noPullRequestsResultsKey = "noPullRequestsResultsKey" as ListDiffable

    private let dataSource: RepositoryDataSource

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        self.dataSource = RepositoryDataSource(hasIssuesEnabled: repo.hasIssuesEnabled)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self
        title = "\(repo.owner)/\(repo.name)"
        
        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        rightItem.accessibilityLabel = NSLocalizedString("More options", comment: "")
        navigationItem.rightBarButtonItem = rightItem
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
    
    var repoUrl: URL {
        return URL(string: "https://github.com/\(repo.owner)/\(repo.name)")!
    }
    
    var repoOwnerUrl: URL {
        return URL(string: "https://github.com/\(repo.owner)")!
    }
    
    func shareAction(sender: UIBarButtonItem) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Send To", comment: ""), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            let safariActivity = TUSafariActivity()
            let controller = UIActivityViewController(activityItems: [strongSelf.repoUrl], applicationActivities: [safariActivity])
            controller.popoverPresentationController?.barButtonItem = sender
            strongSelf.present(controller, animated: true)
        }
    }
    
    func safariAction() -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Open in Safari", comment: ""), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            let controller = SFSafariViewController(url: strongSelf.repoUrl)
            strongSelf.present(controller, animated: true)
        }
    }
    
    func viewOwnerAction() -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("View Owner's Profile", comment: ""), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            let controller = SFSafariViewController(url: strongSelf.repoOwnerUrl)
            strongSelf.present(controller, animated: true)
        }
    }
    
    func viewProjectsAction() -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("View Projects", comment: ""), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            let controller = ProjectListViewController(client: strongSelf.client.githubClient, repository: strongSelf.repo)
            strongSelf.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func onMore(sender: UIBarButtonItem) {
        let alert = UIAlertController()
        
        alert.addAction(shareAction(sender: sender))
        alert.addAction(safariAction())
        alert.addAction(viewOwnerAction())
        alert.addAction(viewProjectsAction()) // Probably a better location for this
        alert.popoverPresentationController?.barButtonItem = sender
        present(alert, animated: true)
    }

    // MARK: Data Loading/Paging

    private func update(dismissRefresh: Bool, animated: Bool) {
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
    }

    func reload() {
        client.fetchReadme { result in
            switch result {
            case .error: break
            case .success(let readme):
                self.dataSource.setReadme(
                    readme,
                    width: self.view.bounds.width,
                    owner: self.repo.owner,
                    repo: self.repo.name,
                    completion: {
                    self.update(dismissRefresh: true, animated: true)
                })
            }
        }

        client.load(containerWidth: view.bounds.width) { result in
            switch result {
            case .error: break
            case .success(let payload):
                self.dataSource.reset(
                    issues: payload.issues.models,
                    issuesNextPage: payload.issues.nextPage,
                    pullRequests: payload.pullRequests.models,
                    pullRequestsNextPage: payload.pullRequests.nextPage
                )
                self.update(dismissRefresh: true, animated: true)
            }
        }
    }

    func loadNextPage() {
        let width = view.bounds.width

        switch dataSource.state {
        case .readme: return
        case .issues:
            client.loadMoreIssues(nextPage: dataSource.issuesNextPage, containerWidth: width, completion: { result in
                switch result {
                case .error: break
                case .success(let payload):
                    self.dataSource.appendIssues(issues: payload.models, page: payload.nextPage)
                    self.update(dismissRefresh: true, animated: false)
                }
            })
        case .pullRequests:
            client.loadMorePullRequests(nextPage: dataSource.pullRequestsNextPage, containerWidth: width, completion: { result in
                switch result {
                case .error: break
                case .success(let payload):
                    self.dataSource.appendPullRequests(pullRequests: payload.models, page: payload.nextPage)
                    self.update(dismissRefresh: true, animated: false)
                }
            })
        }
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        reload()
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var builder = [ListDiffable]()
        builder.append(dataSource.selection)

        let models = dataSource.selectionModels
        builder += models

        if models.count == 0, feed.status == .idle {
            switch dataSource.state {
            case .readme: builder.append(noReadmeResultsKey)
            case .issues: builder.append(noIssuesResultsKey)
            case .pullRequests: builder.append(noPullRequestsResultsKey)
            }
        }

        return builder
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }

        // 28 is the default height of UISegmentedControl
        let controlHeight = 28 + 2*Styles.Sizes.rowSpacing

        if object === noReadmeResultsKey {
            return RepositoryEmptyResultsSectionController(
                topInset: controlHeight,
                topLayoutGuide: topLayoutGuide,
                bottomLayoutGuide: bottomLayoutGuide,
                type: .readme
            )
        } else if object === noIssuesResultsKey {
            return RepositoryEmptyResultsSectionController(
                topInset: controlHeight,
                topLayoutGuide: topLayoutGuide,
                bottomLayoutGuide: bottomLayoutGuide,
                type: .issues
            )
        } else if object === noPullRequestsResultsKey {
            return RepositoryEmptyResultsSectionController(
                topInset: controlHeight,
                topLayoutGuide: topLayoutGuide,
                bottomLayoutGuide: bottomLayoutGuide,
                type: .pullRequests
            )
        } else if object === dataSource.selection {
            return SegmentedControlSectionController(delegate: self, height: controlHeight)
        } else if object === dataSource.loadMore {
            return LoadMoreSectionController(delegate: self)
        } else if object is RepositoryIssueSummaryModel {
            return RepositorySummarySectionController(client: client.githubClient, repo: repo)
        } else if object is RepositoryReadmeModel {
            return RepositoryReadmeSectionController()
        }

        fatalError("Could not find section controller for object")
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    // MARK: SegmentedControlSectionControllerDelegate

    func didChangeSelection(sectionController: SegmentedControlSectionController, model: SegmentedControlModel) {
        update(dismissRefresh: false, animated: false)
    }

    // MARK: LoadMoreSectionControllerDelegate

    func didSelect(sectionController: LoadMoreSectionController) {
        loadNextPage()
    }
}
