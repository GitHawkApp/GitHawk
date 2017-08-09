//
//  IssueLabelsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueLabelsSectionController: ListBindingSectionController<IssueLabelsModel>,
    ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate,
LabelsViewControllerDelegate {

    private var expanded = false
    private var owner: String
    private var repo: String
    private var number: Int
    private var client: GithubClient
    private var labelsOverride: [RepositoryLabel]? = nil

    init(owner: String, repo: String, number: Int, client: GithubClient) {
        self.owner = owner
        self.repo = repo
        self.number = number
        self.client = client
        super.init()
        selectionDelegate = self
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        var viewModels = [ListDiffable]()

        // use override labels when available
        let labels = (labelsOverride ?? self.object?.labels ?? [])
        let colors = labels.map { UIColor.fromHex($0.color) }

        // avoid an empty summary cell
        if labels.count > 0 {
            viewModels.append(IssueLabelSummaryModel(colors: colors))
        }
        if expanded {
            viewModels += labels as [ListDiffable]
        }
        if self.object?.viewerCanUpdate == true {
            viewModels.append("edit" as ListDiffable)
        }

        return viewModels
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell {
        guard let context = self.collectionContext
            else { fatalError("Collection context must be set") }

        let cellClass: AnyClass
        switch viewModel {
        case is IssueLabelSummaryModel: cellClass = IssueLabelSummaryCell.self
        case is RepositoryLabel: cellClass = IssueLabelCell.self
        default: cellClass = IssueLabelEditCell.self
        }
        
        return context.dequeueReusableCell(of: cellClass, for: self, at: index)
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)

        if let cell = collectionContext?.cellForItem(at: index, sectionController: self) as? IssueLabelEditCell {
            guard let controller = UIStoryboard(name: "Labels", bundle: nil).instantiateInitialViewController() as? LabelsViewController
                else { fatalError("Missing labels view controller") }
            controller.configure(
                selected: labelsOverride ?? self.object?.labels ?? [],
                client: client,
                owner: owner,
                repo: repo,
                delegate: self
            )
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .popover
            nav.popoverPresentationController?.sourceView = cell.label
            nav.popoverPresentationController?.sourceRect = cell.label.frame
            viewController?.present(nav, animated: true)
        } else {
            expanded = !expanded
            update(animated: true)
        }
    }

    // MARK: LabelsViewControllerDelegate

    func didDismiss(controller: LabelsViewController, selectedLabels: [RepositoryLabel]) {
        labelsOverride = selectedLabels
        update(animated: true)

        let request = GithubClient.Request(
            path: "repos/\(owner)/\(repo)/issues/\(number)",
            method: .patch,
            parameters: ["labels": selectedLabels.map { $0.name }]
        ) { [weak self] (response, _) in
            if let statusCode = response.response?.statusCode, statusCode != 200 {
                self?.labelsOverride = nil
                self?.update(animated: true)
                if statusCode == 403 {
                    StatusBar.showPermissionsError()
                }
            }
        }
        client.request(request)
    }

}
