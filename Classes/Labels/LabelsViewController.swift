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

final class LabelsViewController: BaseListViewController2<String>, BaseListViewController2DataSource {

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

    // MARK: Overrides

    override func fetch(page: String?) {
        client.client.query(request, result: { data in
            data.repository?.labels?.nodes
        }) { [weak self] result in
            switch result {
            case .success(let nodes):
                self?.labels = nodes.compactMap {
                    guard let node = $0 else { return nil }
                    return RepositoryLabel(color: node.color, name: node.name)
                }.sorted { $0.name < $1.name }
                self?.update(animated: true)
            case .failure:
                Squawk.showGenericError()
            }
        }
    }

    // MARK: BaseListViewController2DataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return labels.map { [selectedLabels] label in
            ListSwiftPair.pair(label) { LabelSectionController(selected: selectedLabels.contains(label)) }
        }
    }

}
