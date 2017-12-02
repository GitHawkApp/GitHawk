//
//  PeopleViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol PeopleViewControllerDelegate: class {
    func didDismiss(
        controller: PeopleViewController,
        type: PeopleViewController.PeopleType,
        selections: [User]
    )
}

final class PeopleViewController: UITableViewController {

    enum PeopleType {
        case assignee
        case reviewer
    }

    private let selectionLimit = 10
    private weak var delegate: PeopleViewControllerDelegate?
    private var owner: String!
    private var repo: String!
    private var client: GithubClient!
    private var users = [User]()
    private let feedRefresh = FeedRefresh()
    private var type: PeopleType!
    private var selections = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.refreshControl = feedRefresh.refreshControl
        feedRefresh.refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)

        feedRefresh.beginRefreshing()
        fetch()
        updateSelectionCount()
    }

    // MARK: Private API

    func updateSelectionCount() {
        let label = UILabel()
        label.font = Styles.Fonts.body
        label.backgroundColor = .clear
        label.textColor = Styles.Colors.Gray.light.color
        label.text = "\(selections.count)/\(selectionLimit)"
        label.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    @objc func onRefresh() {
        fetch()
    }

    func fetch() {
        client.fetchAssignees(owner: owner, repo: repo) { [weak self] result in
            self?.feedRefresh.endRefreshing()
            switch result {
            case .success(let users):
                self?.users = users
                self?.tableView.reloadData()
            case .error:
                ToastManager.showGenericError()
            }
        }
    }

    @IBAction func onDone(_ sender: Any) {
        let selections = users.filter { self.selections.contains($0.login) }
        delegate?.didDismiss(controller: self, type: type, selections: selections)
        dismiss(animated: true)
    }

    // MARK: Public API

    func configure(
        selections: [String],
        type: PeopleType,
        client: GithubClient,
        delegate: PeopleViewControllerDelegate,
        owner: String,
        repo: String
        ) {
        self.selections = Set<String>(selections)
        self.type = type
        self.client = client
        self.delegate = delegate
        self.owner = owner
        self.repo = repo

        switch type {
        case .assignee: title = NSLocalizedString("Assignees", comment: "")
        case .reviewer: title = NSLocalizedString("Reviewers", comment: "")
        }
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        if let cell = cell as? PeopleCell, let avatarURL = URL(string: user.avatar_url) {
            let login = user.login
            cell.configure(avatarURL: avatarURL, username: login, showCheckmark: selections.contains(login))
        }
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let login = users[indexPath.row].login
        if selections.contains(login) {
            selections.remove(login)
        } else {
            if selections.count < selectionLimit {
                selections.insert(login)
            }
        }
        updateSelectionCount()
        tableView.reloadData()
    }

}
