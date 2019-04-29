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
import DropdownTitleView

final class PathHistoryViewController: BaseListViewController<String>,
BaseListViewControllerDataSource {

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

        let titleView = DropdownTitleView()
        titleView.configure(
            title: NSLocalizedString("History", comment: ""),
            subtitle: viewModel.path?.path,
            chevronEnabled: false
        )
        titleView.addTouchEffect()
        navigationItem.titleView = titleView
    }

    override func fetch(page: String?) {
        viewModel.client.client.fetchHistory(
            owner: viewModel.owner,
            repo: viewModel.repo,
            branch: viewModel.branch,
            path: viewModel.path?.path,
            cursor: page,
            width: view.safeContentWidth(with: feed.collectionView),
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

    // MARK: BaseListViewControllerDataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return models.map { ListSwiftPair.pair($0, { PathCommitSectionController() }) }
    }

}
