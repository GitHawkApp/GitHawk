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
ListBindingSectionControllerSelectionDelegate {

    var expanded = false

    override init() {
        super.init()
        selectionDelegate = self
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        guard let object = self.object,
            object.labels.count > 0
            else { return [] }
        let colors = object.labels.map { UIColor.fromHex($0.color) }

        var viewModels: [ListDiffable] = [IssueLabelSummaryModel(colors: colors)]
        if expanded {
            viewModels += object.labels as [ListDiffable]
        }
        if object.viewerCanUpdate {
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
        case is IssueLabelModel: cellClass = IssueLabelCell.self
        default: cellClass = IssueLabelEditCell.self
        }
        
        return context.dequeueReusableCell(of: cellClass, for: self, at: index)
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)

        if collectionContext?.cellForItem(at: index, sectionController: self) is IssueLabelEditCell {
            // TODO
        } else {
            expanded = !expanded
            update(animated: true)
        }
    }

}

