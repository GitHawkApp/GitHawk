//
//  LabelsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class LabelsViewController: UITableViewController {

    private var selectedLabels = Set<RepositoryLabel>()
    private let minContentHeight: CGFloat = 200
    private var labels = [RepositoryLabel]()
    private var client: GithubClient!
    private var request: RepositoryLabelsQuery!
    private let feedRefresh = FeedRefresh()

    override func viewDidLoad() {
        super.viewDidLoad()

        let emptyView = EmptyView()
        emptyView.label.text = NSLocalizedString("No labels found", comment: "")
        emptyView.isHidden = true
        tableView.backgroundView = emptyView

        tableView.refreshControl = feedRefresh.refreshControl
        feedRefresh.refreshControl.addTarget(self, action: #selector(LabelsViewController.onRefresh), for: .valueChanged)

        feedRefresh.beginRefreshing()
        fetch()

        preferredContentSize = CGSize(width: 200, height: 240)
    }

    // MARK: Private API

    @objc func onRefresh() {
        fetch()
    }

    func fetch() {
        client.client.query(request, result: { data in
            data.repository?.labels?.nodes
        }) { [weak self] result in
            self?.feedRefresh.endRefreshing()
            switch result {
            case .success(let nodes):
                self?.update(labels: nodes.flatMap {
                    guard let node = $0 else { return nil }
                    return RepositoryLabel(color: node.color, name: node.name)
                })
            case .failure:
                ToastManager.showGenericError()
            }
        }
    }

    func update(labels: [RepositoryLabel]) {
        self.labels = labels.sorted { $0.name < $1.name }
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.backgroundView?.isHidden = labels.count > 0
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LabelTableCell
            else { fatalError("Wrong cell type") }
        let label = labels[indexPath.row]
        cell.configure(label: label.name, color: label.color.color, selected: selectedLabels.contains(label))
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: trueUnlessReduceMotionEnabled)
        let label = labels[indexPath.row]
        if selectedLabels.contains(label) {
            selectedLabels.remove(label)
        } else {
            selectedLabels.insert(label)
        }
        tableView.reloadData()
    }

    // MARK: Public API

    func configure(
        selected: [RepositoryLabel],
        client: GithubClient,
        owner: String,
        repo: String
        ) {
        self.selectedLabels = Set(selected)
        self.client = client
        self.request = RepositoryLabelsQuery(owner: owner, repo: repo)
    }

    var selected: [RepositoryLabel] {
        return Array(selectedLabels)
    }

}
