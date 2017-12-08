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
    ListBindingSectionControllerDataSource {

    private var sizeCache = [String: CGSize]()

    override init() {
        super.init()
        minimumInteritemSpacing = Styles.Sizes.labelSpacing
        minimumLineSpacing = Styles.Sizes.labelSpacing
        inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        var viewModels = [ListDiffable]()

        return self.object?.labels ?? []

        // use override labels when available
        let labels = self.object?.labels ?? []

        // avoid an empty summary cell
        if labels.count > 0 {
            viewModels.append(IssueLabelSummaryModel(labels: labels))
        }
        
        return viewModels
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width,
        let viewModel = viewModel as? RepositoryLabel
            else { fatalError("Collection context must be set") }

        let key = viewModel.name

        if let size = sizeCache[key] {
            return size
        }

        let size = LabelListCell.size(key)
        sizeCache[key] = size
        return size
//
//        let fontAttributes = [NSAttributedStringKey.font: Styles.Fonts.smallTitle]
//        let labelStringWidth = (label.name as NSString).size(withAttributes: fontAttributes).width
//        let labelHorizontalPadding: CGFloat = Styles.Sizes.labelTextPadding * 2
//        labelTextTotalWidth += (labelStringWidth + labelHorizontalPadding)
//
////        let labels = (self.object?.labels ?? [])
//
//        var labelTextTotalWidth = CGFloat()
//        for label in labels {
//
//        }
//        let labelInteritemSpacing = labels.count > 1 ? CGFloat(labels.count - 1) * Styles.Sizes.labelSpacing : 0.0
//        labelTextTotalWidth += labelInteritemSpacing
//
//        let labelListViewWidth = width - (2 * Styles.Sizes.gutter)
//        let labelRows = ceil(labelTextTotalWidth / labelListViewWidth)
//        let rowSpacing = labelRows > 1 ? (labelRows - 1) * Styles.Sizes.labelSpacing : 0.0
//        let labelListViewVerticalPadding: CGFloat = Styles.Sizes.labelSpacing * 2
//        let totalLabelsCellheight = (Styles.Sizes.labelRowHeight * labelRows) + rowSpacing + labelListViewVerticalPadding
//
//        return CGSize(width: width, height: totalLabelsCellheight)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        guard let cell = collectionContext?.dequeueReusableCell(of: LabelListCell.self, for: self, at: index) as? LabelListCell
            else { fatalError("Missing context or wrong cell") }
        return cell

//        guard let context = self.collectionContext
//            else { fatalError("Collection context must be set") }
//        guard let cell = context.dequeueReusableCell(of: IssueLabelSummaryCell.self, for: self, at: index) as? IssueLabelSummaryCell
//            else { fatalError("Cell not bindable") }
//        return cell
    }
}
