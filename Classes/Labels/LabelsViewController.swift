//
//  LabelsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import Squawk

final class LabelsViewController: BaseListViewController<String>,
BaseListViewControllerDataSource,
LabelSectionControllerDelegate {

    private let selectedLabels: Set<RepositoryLabel>
    private var labels = [RepositoryLabel]()
    private let owner: String
    private let repo: String
    private let client: GithubClient

    init(
        selected: [RepositoryLabel],
        client: GithubClient,
        owner: String,
        repo: String
        ) {
        self.selectedLabels = Set(selected)
        self.client = client
        self.owner = owner
        self.repo = repo
        super.init(emptyErrorMessage: NSLocalizedString("No labels found", comment: ""))
        preferredContentSize = Styles.Sizes.contextMenuSize
        title = Constants.Strings.labels
        feed.collectionView.backgroundColor = Styles.Colors.menuBackgroundColor.color
        feed.collectionView.indicatorStyle = .white
        feed.setLoadingSpinnerColor(to: .white)
        dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        addMenuDoneButton()
        addMenuClearButton()
    }

    // MARK: Public API

    var selected: [RepositoryLabel] {
        return labels.filter {
            if let sectionController: LabelSectionController = feed.swiftAdapter.sectionController(for: $0) {
                return sectionController.selected
            }
            return false
        }
    }

    func addMenuClearButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: Constants.Strings.clear,
            style: .plain,
            target: self,
            action: #selector(onMenuClear)
        )
        navigationItem.leftBarButtonItem?.tintColor = Styles.Colors.Gray.light.color
        navigationItem.leftBarButtonItem?.isEnabled = selectedLabels.count > 0
    }

    func updateClearButtonEnabled() {
        navigationItem.leftBarButtonItem?.isEnabled = selected.count > 0
    }

    @objc func onMenuClear() {
        self.selected.forEach {
            if let sectionController: LabelSectionController = feed.swiftAdapter.sectionController(for: $0) {
                sectionController.didSelectItem(at: 0)
            }
        }

        updateClearButtonEnabled()
    }

    // MARK: Overrides

    override func fetch(page: String?) {
        client.fetchRepositoryLabels(
            owner: owner,
            repo: repo,
            nextPage: page as String?
        ) {  [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let payload):
                self?.labels = payload.labels.sorted { $0.name < $1.name }
                strongSelf.update(page: payload.nextPage, animated: true)
            case .error(let error):
                Squawk.show(error: error)
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return labels.map { [selectedLabels] label in
            ListSwiftPair.pair(label) {
                let controller = LabelSectionController(selected: selectedLabels.contains(label))
                controller.delegate = self
                return controller
            }
        }
    }

    // MARK: LabelSectionControllerDelegate

    func didSelect(controller: LabelSectionController) {
        updateClearButtonEnabled()
    }
}
