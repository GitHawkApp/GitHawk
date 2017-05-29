//
//  IssueCommentSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentSectionController: IGListBindingSectionController<IssueCommentModel> {

    fileprivate var collapsed = true

    override init() {
        super.init()
        dataSource = self
    }

}

extension IssueCommentSectionController: IGListBindingSectionControllerDataSource {

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        viewModelsFor object: Any
        ) -> [IGListDiffable] {
        guard let object = self.object else { return [] }

        var bodies = [IGListDiffable]()
        for body in object.bodyModels {
            bodies.append(body)
            if body === object.collapse?.model {
                break
            }
        }

        return [ object.details ] + bodies
    }

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let context = self.collectionContext else { return .zero }
        let height: CGFloat
        if (viewModel as AnyObject) === object?.collapse?.model {
            height = object?.collapse?.height ?? 0
        } else {
            height = bodyHeight(viewModel: viewModel)
        }
        return CGSize(width: context.containerSize.width, height: height)
    }

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = self.collectionContext else { return UICollectionViewCell() }
        let cellClass: AnyClass
        if viewModel is IssueCommentDetailsViewModel {
            cellClass = IssueCommentDetailCell.self
        } else if viewModel is IssueCommentImageModel {
            cellClass = IssueCommentImageCell.self
        } else if viewModel is IssueCommentCodeBlockModel {
            cellClass = IssueCommentCodeBlockCell.self
        } else if viewModel is IssueCommentSummaryModel {
            cellClass = IssueCommentSummaryCell.self
        } else {
            cellClass = IssueCommentTextCell.self
        }
        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)
        if let cell = cell as? CollapsibleCell {
            cell.setCollapse(visible: collapsed && (viewModel as AnyObject) === object?.collapse?.model)
        }
        return cell
    }
    
}
