//
//  IssueMergeSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMergeSectionController: ListBindingSectionController<IssueMergeModel>,
ListBindingSectionControllerDataSource {

    override init() {
        super.init()
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = self.object else { return [] }

        var viewModels = [ListDiffable]()

        if object.contexts.count > 0 {
            let success = object.contexts.reduce(true, { $0 && $1.state == .success })
            viewModels.append(IssueMergeSummaryModel(
                title: success ?
                    NSLocalizedString("All checks passed", comment: "")
                    : NSLocalizedString("Some checks failed", comment: ""),
                state: success ? .success : .failure
            ))
        }

        viewModels += object.contexts as [ListDiffable]

        let mergeable = object.state == .mergeable
        viewModels.append(IssueMergeSummaryModel(
            title: mergeable ?
                NSLocalizedString("No conflicts with base branch", comment: "")
                : NSLocalizedString("Merge conflicts found", comment: ""),
            state: mergeable ? .success : .warning
        ))

        // TODO get preferred query from store
        viewModels.append(IssueMergeButtonModel(enabled: mergeable, type: .merge))

        return viewModels
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.insetContainerSize.width
            else { fatalError() }
        let height: CGFloat
        switch viewModel {
        case is IssueMergeButtonModel: height = Styles.Sizes.tableCellHeightLarge
//        case is IssueMergeContextModel: height = Styles.Sizes.labelRowHeight
        default: height = Styles.Sizes.tableCellHeight
        }
        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        let cellType: (UICollectionViewCell & ListBindable).Type
        switch viewModel {
        case is IssueMergeButtonModel: cellType = IssueMergeButtonCell.self
        case is IssueMergeSummaryModel: cellType = IssueMergeSummaryCell.self
        case is IssueMergeContextModel: cellType = IssueMergeContextCell.self
        default: fatalError()
        }
        guard let cell = collectionContext?.dequeueReusableCell(of: cellType, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError() }

        if let cell = cell as? IssueCommentBaseCell {
            cell.border = index == 0 ? .head : index == self.viewModels.count - 1 ? .tail : .neck
        }

        return cell
    }

}
