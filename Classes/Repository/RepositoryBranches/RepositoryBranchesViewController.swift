//
//  RepoBranchesViewController.swift
//  Freetime
//
//  Created by B_Litwin on 9/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Squawk
import IGListKit

final class RepositoryBranchesViewController: BaseListViewController<String>,
BaseListViewControllerDataSource,
RepositoryBranchSectionControllerDelegate {

    private let owner: String
    private let repo: String
    private let client: GithubClient
    private var branches: [String] = []
    private let defaultBranch: String
    public private(set) var selectedBranch: String

    init(defaultBranch: String,
         selectedBranch: String,
         owner: String,
         repo: String,
         client: GithubClient
        ) {
        self.defaultBranch = defaultBranch
        self.selectedBranch = selectedBranch
        self.owner = owner
        self.repo = repo
        self.client = client
        super.init(emptyErrorMessage: "Couldn't load repository branches")

        title = NSLocalizedString("Branches", comment: "")
        preferredContentSize = Styles.Sizes.contextMenuSize
        feed.collectionView.backgroundColor = Styles.Colors.menuBackgroundColor.color
        feed.collectionView.indicatorStyle = .white
        feed.setLoadingSpinnerColor(to: .white)
        dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        addMenuDoneButton()
    }

    static func arrangeBranches(selectedBranch: String, defaultBranch: String, branches: [String]) -> [String] {
        var branches = branches

        if let selectedBranchIndex = branches.index(of: selectedBranch) {
            let elem = branches.remove(at: selectedBranchIndex)
            branches.insert(elem, at: 0)
        }

        if defaultBranch != selectedBranch,
            let defaultBranchIndex = branches.index(of: defaultBranch) {
            let elem = branches.remove(at: defaultBranchIndex)
            branches.insert(elem, at: 1)
        }

        return branches
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func fetch(page: String?) {
        client.fetchRepositoryBranches(
            owner: owner,
            repo: repo,
            nextPage: page as String?
        ) {  [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let payload):
                strongSelf.branches = RepositoryBranchesViewController.arrangeBranches(
                    selectedBranch: strongSelf.selectedBranch,
                    defaultBranch: strongSelf.defaultBranch,
                    branches: strongSelf.branches + payload.branches
                )
                strongSelf.update(page: payload.nextPage, animated: true)
            case .error(let error):
                Squawk.show(error: error)
                strongSelf.error(animated: trueUnlessReduceMotionEnabled)
            }
        }
    }

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        guard feed.status == .idle else { return [] }
        return branches.map {
            let value = RepositoryBranchViewModel(branch: $0,
                                                  selected: $0 == self.selectedBranch)

            return ListSwiftPair(value) { [weak self] in
                let controller = RepositoryBranchSectionController()
                controller.delegate = self
                return controller
            }
        }
    }

    func didSelect(value: RepositoryBranchViewModel) {
        self.selectedBranch = value.branch
        update(animated: trueUnlessReduceMotionEnabled)
    }
}
