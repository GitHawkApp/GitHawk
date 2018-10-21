//
//  PathHistoryViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import Squawk

final class PathHistoryViewController: BaseListViewController2<String>,
BaseListViewController2DataSource {

    private let viewModel: PathHistoryViewModel
    private var models = [PathCommitModel]()

    init(viewModel: PathHistoryViewModel) {
        self.viewModel = viewModel
        super.init(emptyErrorMessage: NSLocalizedString("Cannot load history.", comment: ""))
        dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleView = NavigationTitleDropdownView(chevronVisible: false)
        titleView.configure(
            title: NSLocalizedString("History", comment: ""),
            subtitle: viewModel.path?.path
        )
        navigationItem.titleView = titleView
    }

    override func fetch(page: String?) {
        // assumptions here, but the collectionview may not have been laid out or content size found
        // assume the collectionview is pinned to the view's bounds
        let contentInset = feed.collectionView.contentInset
        let width = view.bounds.width - contentInset.left - contentInset.right

        viewModel.client.client.fetchHistory(
            owner: viewModel.owner,
            repo: viewModel.repo,
            branch: viewModel.branch,
            path: viewModel.path?.path,
            cursor: page,
            width: width,
            contentSizeCategory: UIApplication.shared.preferredContentSizeCategory
        ) { [weak self] result in
                switch result {
                case .error(let error):
                    Squawk.show(error: error)
                case .success(let commits, let nextPage):
                    if page == nil {
                        self?.models = commits
                    } else {
                        self?.models += commits
                    }
                    self?.update(page: nextPage, animated: trueUnlessReduceMotionEnabled)
                }
        }
    }

    // MARK: BaseListViewController2DataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return models.map { ListSwiftPair.pair($0, { PathCommitSectionController() }) }
    }

}
