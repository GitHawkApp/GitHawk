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
    private let client: GithubClient
    private let request: RepositoryLabelsQuery

    init(
        selected: [RepositoryLabel],
        client: GithubClient,
        owner: String,
        repo: String
        ) {
        self.selectedLabels = Set(selected)
        self.client = client
        self.request = RepositoryLabelsQuery(owner: owner, repo: repo)
        super.init(emptyErrorMessage: NSLocalizedString("No labels found", comment: ""))
        preferredContentSize = Styles.Sizes.contextMenuSize
        title = Constants.Strings.labels
        feed.collectionView.backgroundColor = Styles.Colors.menuBackgroundColor.color
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
        client.client.query(request, result: { data in
            data.repository?.labels?.nodes
        }, completion: { [weak self] result in
            switch result {
            case .success(let nodes):
                self?.labels = nodes.compactMap {
                    guard let node = $0 else { return nil }
                    return RepositoryLabel(color: node.color, name: node.name)
                }.sorted { $0.name < $1.name }
                self?.update(animated: true)
            case .failure(let error):
                Squawk.show(error: error)
            }
        })
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
