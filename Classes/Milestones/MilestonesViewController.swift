//
//  MilestonesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class MilestonesViewController: UITableViewController {

    public private(set) var selected: Milestone?

    private var owner: String!
    private var repo: String!
    private var client: GithubClient!
    private let feedRefresh = FeedRefresh()
    private var milestones = [Milestone]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundView = EmptyLoadingView()

        tableView.refreshControl = feedRefresh.refreshControl
        feedRefresh.refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)

        fetch()

        preferredContentSize = CGSize(width: 200, height: 240)
    }

    // MARK: Public API

    func configure(
        client: GithubClient,
        owner: String,
        repo: String,
        selected: Milestone?
        ) {
        self.client = client
        self.owner = owner
        self.repo = repo
        self.selected = selected
    }

    // MARK: Private API

    @objc func onRefresh() {
        fetch()
    }

    func fetch() {
        client.fetchMilestones(owner: owner, repo: repo) { [weak self] (result) in
            switch result {
            case .success(let milestones):
                self?.milestones = milestones
                self?.tableView.reloadData()
            case .error:
                ToastManager.showGenericError()
            }
            self?.feedRefresh.endRefreshing()

            if self?.milestones.count == 0 {
                let emptyView = EmptyView()
                emptyView.label.text = NSLocalizedString("No labels found", comment: "")
                self?.tableView.backgroundView = emptyView
            } else {
                self?.tableView.backgroundView?.removeFromSuperview()
            }
        }
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return milestones.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? MilestoneCell {
            let milestone = milestones[indexPath.row]
            cell.configure(
                title: milestone.title,
                date: milestone.dueOn,
                showCheckmark: milestone == selected
            )
        }
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: trueUnlessReduceMotionEnabled)
        let milestone = milestones[indexPath.row]
        if milestone == selected {
            selected = nil
        } else {
            selected = milestone
        }
        tableView.reloadData()
    }

}
