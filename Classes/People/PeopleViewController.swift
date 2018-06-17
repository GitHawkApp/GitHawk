//
//  PeopleViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import GitHubAPI

final class PeopleViewController: BaseListViewController2<String>,
BaseListViewController2DataSource,
PeopleSectionControllerDelegate {

    enum PeopleType {
        case assignee
        case reviewer
    }

    public let type: PeopleType

    private let selections: Set<String>
    private let selectionLimit = 10
    private var users = [IssueAssigneeViewModel]()
    private let client: GithubClient
    private var owner: String
    private var repo: String

    init(
        selections: [String],
        type: PeopleType,
        client: GithubClient,
        owner: String,
        repo: String
        ) {
        self.selections = Set<String>(selections)
        self.type = type
        self.client = client
        self.owner = owner
        self.repo = repo

        super.init(emptyErrorMessage: NSLocalizedString("Cannot load users.", comment: ""))

        self.dataSource = self

        switch type {
        case .assignee: title = NSLocalizedString("Assignees", comment: "")
        case .reviewer: title = NSLocalizedString("Reviewers", comment: "")
        }

        preferredContentSize = CGSize(width: 280, height: 240)
        updateSelectionCount()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    var selected: [IssueAssigneeViewModel] {
        return users.filter {
            if let sectionController: PeopleSectionController = feed.swiftAdapter.sectionController(for: $0) {
                return sectionController.selected
            }
            return false
        }
    }

    // MARK: Private API

    func updateSelectionCount() {
        let label = UILabel()
        label.font = Styles.Text.body.preferredFont
        label.backgroundColor = .clear
        label.textColor = Styles.Colors.Gray.light.color
        label.text = "\(selected.count)/\(selectionLimit)"
        label.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    // MARK: Overrides

    override func fetch(page: String?) {

        client.client.send(
            V3AssigneesRequest(
                owner: owner,
                repo: repo,
                page: (page as NSString?)?.integerValue ?? 1
            )
        ) { [weak self] result in
            switch result {
            case .success(let response):
                let sortedUsers = response.data.sorted {
                    $0.login.caseInsensitiveCompare($1.login) == .orderedAscending
                }
                let users = sortedUsers.map { IssueAssigneeViewModel(login: $0.login, avatarURL: $0.avatarUrl) }
                if page != nil {
                    self?.users += users
                } else {
                    self?.users = users
                }
                self?.update(animated: true)

                let nextPage: String?
                if let next = response.next {
                    nextPage = "\(next)"
                } else {
                    nextPage = nil
                }
                self?.update(page: nextPage, animated: true)
            case .failure:
                ToastManager.showGenericError()
            }
        }
    }

    // MARK: BaseListViewController2DataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return users.map { [selections] user in
            return ListSwiftPair.pair(user) { [weak self] in
                let controller = PeopleSectionController(selected: selections.contains(user.login))
                controller.delegate = self
                return controller
            }
        }
    }

    // MARK: PeopleSectionControllerDelegate

    func didSelect(controller: PeopleSectionController) {
        updateSelectionCount()
    }

}
