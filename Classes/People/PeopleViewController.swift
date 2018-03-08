//
//  PeopleViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol PeopleViewControllerDelegate: class {
    func didDismiss(
        controller: PeopleViewController,
        type: PeopleViewController.PeopleType,
        selections: [User]
    )
}

final class PeopleViewController: BaseListViewController<NSNumber>,
BaseListViewControllerDataSource,
PeopleSectionControllerDelegate {

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
    private var type: PeopleType!
    private var selections = Set<String>()

    init(selections: [String],
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

        super.init(emptyErrorMessage: "Cannot load users.", dataSource: self)

        switch type {
        case .assignee: title = NSLocalizedString("Assignees", comment: "")
        case .reviewer: title = NSLocalizedString("Reviewers", comment: "")
        }

        updateSelectionCount()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(onDone(_:)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    override func fetch(page: NSNumber?) {
        client.fetchAssignees(
            owner: owner,
            repo: repo,
            page: page?.intValue ?? 1
        ) { [weak self] result in
            self?.handle(result: result, append: page != nil)
        }
    }

    func handle(result: Result<([User], Int?)>, append: Bool) {
        switch result {
        case .success(let users, let next):
            if append {
                self.users += users
            } else {
                self.users = users
            }
            update(page: next as NSNumber?, animated: trueUnlessReduceMotionEnabled)
        case .error:
            ToastManager.showGenericError()
        }
    }

    @IBAction func onDone(_ sender: Any) {
        let selections = users.filter { self.selections.contains($0.login) }
        delegate?.didDismiss(controller: self, type: type, selections: selections)
        dismiss(animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        let models = users.flatMap { user -> IssueAssigneeViewModel? in
            guard let avatarURL = URL(string: user.avatar_url) else { return nil }
            return IssueAssigneeViewModel(login: user.login, avatarURL: avatarURL)
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
