//
//  PeopleViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import GitHubAPI

final class PeopleViewController: BaseListViewController<NSNumber>,
BaseListViewControllerDataSource,
PeopleSectionControllerDelegate {

    enum PeopleType {
        case assignee
        case reviewer
    }

    public let type: PeopleType

    private var selections = Set<String>()
    private let selectionLimit = 10
    private var owner: String!
    private var repo: String!
    private var client: GithubClient!
    private var users = [V3User]()

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

        super.init(emptyErrorMessage: "Cannot load users.", dataSource: self)

        switch type {
        case .assignee: title = NSLocalizedString("Assignees", comment: "")
        case .reviewer: title = NSLocalizedString("Reviewers", comment: "")
        }

        updateSelectionCount()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        feed.collectionView.backgroundColor = .white
        preferredContentSize = CGSize(width: 280, height: 240)
    }

    // MARK: Public API

    var selectedUsers: [V3User] {
        return users.filter { self.selections.contains($0.login) }
    }

    // MARK: Override

    override func fetch(page: NSNumber?) {
        client.client.send(
            V3AssigneesRequest(
                owner: owner,
                repo: repo,
                page: page?.intValue ?? 1
            )
        ) { [weak self] result in
            switch result {
            case .success(let response):
                let sortedUsers = response.data.sorted {
                    $0.login.caseInsensitiveCompare($1.login) == .orderedAscending
                }
                if page != nil {
                    self?.users += sortedUsers
                } else {
                    self?.users = sortedUsers
                }
                self?.update(page: response.next as NSNumber?, animated: trueUnlessReduceMotionEnabled)
            case .failure:
                ToastManager.showGenericError()
            }
        }
    }

    // MARK: Private API

    func updateSelectionCount() {
        let label = UILabel()
        label.font = Styles.Text.body.preferredFont
        label.backgroundColor = .clear
        label.textColor = Styles.Colors.Gray.light.color
        label.text = "\(selections.count)/\(selectionLimit)"
        label.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        let models = users.map { user -> IssueAssigneeViewModel in
            return IssueAssigneeViewModel(login: user.login, avatarURL: user.avatarUrl)
        }
        return models
    }

    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController {
        guard let user = model as? IssueAssigneeViewModel else { fatalError("Incorrect model type") }
        let isSelected = selections.contains(user.login)
        return PeopleSectionController(isSelected: isSelected, delegate: self)
    }

    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController {
        return ListSingleSectionController(cellClass: LabelCell.self, configureBlock: { (_, cell: UICollectionViewCell) in
            guard let cell = cell as? LabelCell else { return }
            cell.label.text = NSLocalizedString("No users found.", comment: "")
        }, sizeBlock: { [weak self] (_, context: ListCollectionContext?) -> CGSize in
            guard let context = context,
                let strongSelf = self
                else { return .zero }
            return CGSize(
                width: context.containerSize.width,
                height: context.containerSize.height - strongSelf.view.safeAreaInsets.top - strongSelf.view.safeAreaInsets.bottom
            )
        })
    }

    // MARK: PeopleSectionControllerDelegate

    func shouldUpdateCellForUser(login: String) -> Bool {
        let isSelected = selections.contains(login)
        if isSelected {
            selections.remove(login)
            updateSelectionCount()
            return true
        } else if !isSelected && selections.count < selectionLimit {
            selections.insert(login)
            updateSelectionCount()
            return true
        }
        return false
    }
}
