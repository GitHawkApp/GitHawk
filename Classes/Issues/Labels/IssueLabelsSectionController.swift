//
//  IssueLabelsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueLabelsSectionController: IGListBindingSectionController<IssueLabelsModel>,
IGListBindingSectionControllerDataSource,
IGListBindingSectionControllerSelectionDelegate {

    var expanded = false

    override init() {
        super.init()
        selectionDelegate = self
        dataSource = self
    }

    // MARK: IGListBindingSectionControllerDataSource

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, viewModelsFor object: Any) -> [IGListDiffable] {
        guard let object = self.object,
            object.labels.count > 0
            else { return [] }
        let colors = object.labels.map { UIColor.fromHex($0.color) }
        return [ IssueLabelSummaryModel(colors: colors) ]
            + (expanded ? object.labels : [])
    }

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        guard let context = self.collectionContext else { return .zero }
        return CGSize(width: context.containerSize.width, height: 30    )
    }

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell {
        guard let context = self.collectionContext else { return UICollectionViewCell() }
        let cellClass: AnyClass
        if viewModel is IssueLabelSummaryModel {
            cellClass = IssueLabelSummaryCell.self
        } else {
            cellClass = IssueLabelCell.self
        }
        return context.dequeueReusableCell(of: cellClass, for: self, at: index)
    }

    // MARK: IGListBindingSectionControllerSelectionDelegate

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        expanded = !expanded
        update(animated: true)
    }

}
