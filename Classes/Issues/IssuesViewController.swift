//
//  IssuesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssuesViewController: UIViewController {

    fileprivate let client: GithubClient
    fileprivate let owner: String
    fileprivate let repo: String
    fileprivate let number: String
    fileprivate var issue: Issue?
    fileprivate var models = [IGListDiffable]()
    lazy fileprivate var feed: Feed = { Feed(viewController: self, delegate: self) }()

    init(
        client: GithubClient,
        owner: String,
        repo: String,
        number: String
        ) {
        self.client = client
        self.owner = owner
        self.repo = repo
        self.number = number
        super.init(nibName: nil, bundle: nil)
        title = "\(owner)/\(repo)#\(number)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self
    }

}

extension IssuesViewController: IGListAdapterDataSource {

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return models
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is NSAttributedStringSizing {
            return IssueTitleSectionController()
        } else if object is IssueCommentModel {
            return IssueCommentSectionController()
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

}

extension IssuesViewController: FeedDelegate {

    private func createModels(_ issue: Issue) {
        self.issue = issue
        createViewModels(issue: issue, width: self.view.bounds.width) { results in
            self.models = results
            self.feed.finishLoading(fromNetwork: true)
        }
    }

    func loadFromNetwork(feed: Feed) {
        let issue = Issue(json: [
            "assignees": [],
            "body": "An `NSIndexPath` is being built from IGListAdapter+UICollectionView.m\r\nbefore being passed to\r\n`-[IGListSupplementaryViewSource sizeForSupplementaryViewOfKind:atIndex:]`\r\nhowever this later is taking the `item` instead of the `section` -\r\nresulting in the index always being equal to 0, even for section\r\nindexes > 0.\r\n\r\n## Changes in this pull request\r\n\r\nIssue fixed: #714\r\n\r\n### Checklist\r\n\r\n- [x] All tests pass. Demo project builds and runs.\r\n- [x] I added tests, an experiment, or detailed why my change isn't tested.\r\n- [x] I added an entry to the `CHANGELOG.md` for any breaking changes, enhancements, or bug fixes.\r\n- [x] I have reviewed the [contributing guide](https://github.com/Instagram/IGListKit/blob/master/.github/CONTRIBUTING.md)\r\n",
            "closed_at": "2017-05-08T16:50:45Z",
            "closed_by": [
                "avatar_url": "https://avatars3.githubusercontent.com/u/12944582?v=3",
                "events_url": "https://api.github.com/users/gobetti/events{/privacy}",
                "followers_url": "https://api.github.com/users/gobetti/followers",
                "following_url": "https://api.github.com/users/gobetti/following{/other_user}",
                "gists_url": "https://api.github.com/users/gobetti/gists{/gist_id}",
                "gravatar_id": "",
                "html_url": "https://github.com/gobetti",
                "id": 12944582,
                "login": "gobetti",
                "organizations_url": "https://api.github.com/users/gobetti/orgs",
                "received_events_url": "https://api.github.com/users/gobetti/received_events",
                "repos_url": "https://api.github.com/users/gobetti/repos",
                "site_admin": false,
                "starred_url": "https://api.github.com/users/gobetti/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/gobetti/subscriptions",
                "type": "User",
                "url": "https://api.github.com/users/gobetti"
            ],
            "comments": 5,
            "comments_url": "https://api.github.com/repos/Instagram/IGListKit/issues/715/comments",
            "created_at": "2017-05-03T20:21:11Z",
            "events_url": "https://api.github.com/repos/Instagram/IGListKit/issues/715/events",
            "html_url": "https://github.com/Instagram/IGListKit/pull/715",
            "id": 226103257,
            "labels": [
                [
                    "color": "70C050",
                    "default": false,
                    "id": 438144450,
                    "name": "CLA Signed",
                    "url": "https://api.github.com/repos/Instagram/IGListKit/labels/CLA%20Signed"
                ]
            ],
            "labels_url": "https://api.github.com/repos/Instagram/IGListKit/issues/715/labels{/name}",
            "locked": false,
            "number": 715,
            "pull_request": [
                "diff_url": "https://github.com/Instagram/IGListKit/pull/715.diff",
                "html_url": "https://github.com/Instagram/IGListKit/pull/715",
                "patch_url": "https://github.com/Instagram/IGListKit/pull/715.patch",
                "url": "https://api.github.com/repos/Instagram/IGListKit/pulls/715"
            ],
            "repository_url": "https://api.github.com/repos/Instagram/IGListKit",
            "state": "closed",
            "title": "Fixes sizeForSupplementaryViewOfKind always at index=0",
            "updated_at": "2017-05-09T14:07:55Z",
            "url": "https://api.github.com/repos/Instagram/IGListKit/issues/715",
            "user": [
                "avatar_url": "https://avatars3.githubusercontent.com/u/12944582?v=3",
                "events_url": "https://api.github.com/users/gobetti/events{/privacy}",
                "followers_url": "https://api.github.com/users/gobetti/followers",
                "following_url": "https://api.github.com/users/gobetti/following{/other_user}",
                "gists_url": "https://api.github.com/users/gobetti/gists{/gist_id}",
                "gravatar_id": "",
                "html_url": "https://github.com/gobetti",
                "id": 12944582,
                "login": "gobetti",
                "organizations_url": "https://api.github.com/users/gobetti/orgs",
                "received_events_url": "https://api.github.com/users/gobetti/received_events",
                "repos_url": "https://api.github.com/users/gobetti/repos",
                "site_admin": false,
                "starred_url": "https://api.github.com/users/gobetti/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/gobetti/subscriptions",
                "type": "User",
                "url": "https://api.github.com/users/gobetti"
            ]
            ])
        createModels(issue!)

        //        client.requestIssue(owner: owner, repo: repo, number: number) { result in
        //            switch result {
        //            case .success(let issue):
        //                self.createModels(issue)
        //            case .failure: print("nope")
        //                feed.finishLoading(fromNetwork: true)
        //            }
        //        }
    }
    
}
