//
//  MilestonesViewController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class MilestonesViewController2: BaseListViewController2,
BaseListViewController2DataSource,
MilestoneSectionControllerDelegate {

    public private(set) var selected: Milestone?

    private var owner: String!
    private var repo: String!
    private var client: GithubClient!
    private let feedRefresh = FeedRefresh()
    private var milestones = [Milestone]()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()

    init(
        client: GithubClient,
        owner: String,
        repo: String,
        selected: Milestone?
        ) {
        self.client = client
        self.owner = owner
        self.repo = repo
        self.selected = selected
        super.init(emptyErrorMessage: NSLocalizedString("No milestones found.", comment: ""))
        title = NSLocalizedString("Labels", comment: "")
        preferredContentSize = CGSize(width: 200, height: 240)
        dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override func fetch(page: String?) {
        client.fetchMilestones(owner: owner, repo: repo) { [weak self] (result) in
            switch result {
            case .success(let milestones):
                self?.milestones = milestones
            case .error:
                ToastManager.showGenericError()
            }
            self?.update(animated: true)
        }
    }

    // MARK: BaseListViewController2DataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return milestones.map { [dateFormatter, selected] milestone in
            let due: String
            if let date = milestone.dueOn {
                let format = NSLocalizedString("Due by %@", comment: "")
                due = String(format: format, dateFormatter.string(from: date))
            } else {
                due = NSLocalizedString("No due date", comment: "")
            }
            let value = MilestoneViewModel(title: milestone.title, due: due, selected: selected == milestone)
            return ListSwiftPair.pair(value) { [weak self] in
                let controller = MilestoneSectionController()
                controller.delegate = self
                return controller
            }
        }
    }

    // MARK: MilestoneSectionControllerDelegate

    func didSelect(value: MilestoneViewModel, controller: MilestoneSectionController) {
        if value.selected {
            selected = nil
        } else {
            selected = milestones[controller.section]
        }
        update(animated: true)
    }

}

