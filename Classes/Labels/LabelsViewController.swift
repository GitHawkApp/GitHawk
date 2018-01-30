//
//  LabelsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol LabelsViewControllerDelegate: class {
    func didDismiss(controller: LabelsViewController, selectedLabels: [RepositoryLabel])
}

final class LabelsViewController: UITableViewController {

    private let minContentHeight: CGFloat = 200
    private weak var delegate: LabelsViewControllerDelegate?
    private var labels = [RepositoryLabel]()
    private var selectedLabels = Set<String>()
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
    }

    // MARK: Private API

    @objc func onRefresh() {
        fetch()
    }

    func fetch() {
        client.fetch(query: request) { [weak self] (result, _) in
            self?.feedRefresh.endRefreshing()
            if let nodes = result?.data?.repository?.labels?.nodes {
                var labels = [RepositoryLabel]()
                for node in nodes {
                    guard let node = node else { continue }
                    labels.append(RepositoryLabel(color: node.color, name: node.name))
                }
                self?.update(labels: labels)
            } else {
                ToastManager.showGenericError()
            }
        }
    }

    func update(labels: [RepositoryLabel]) {
        self.labels = labels.sorted { $0.name < $1.name }
        tableView.reloadData()
        tableView.layoutIfNeeded()

        var contentSize = tableView.contentSize
        contentSize.height = max(minContentHeight, contentSize.height)
        navigationController?.preferredContentSize = contentSize

        tableView.backgroundView?.isHidden = labels.count > 0
    }

    @IBAction func onDone() {
        var selected = [RepositoryLabel]()
        for label in labels {
            if selectedLabels.contains(label.name) {
                selected.append(label)
            }
        }
        delegate?.didDismiss(controller: self, selectedLabels: selected)
        dismiss(animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LabelTableCell
            else { fatalError("Wrong cell type") }
        let label = labels[indexPath.row]
        cell.configure(label: label.name, color: label.color.color, selected: selectedLabels.contains(label.name))
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: trueUnlessReduceMotionEnabled)
        let name = labels[indexPath.row].name
        if selectedLabels.contains(name) {
            selectedLabels.remove(name)
        } else {
            selectedLabels.insert(name)
        }
        tableView.reloadData()
    }

    // MARK: Public API

    func configure(
        selected: [RepositoryLabel],
        client: GithubClient,
        owner: String,
        repo: String,
        delegate: LabelsViewControllerDelegate
        ) {
        var set = Set<String>()
        for l in selected {
            set.insert(l.name)
        }
        self.selectedLabels = set
        self.client = client
        self.request = RepositoryLabelsQuery(owner: owner, repo: repo)
        self.delegate = delegate
    }

}
