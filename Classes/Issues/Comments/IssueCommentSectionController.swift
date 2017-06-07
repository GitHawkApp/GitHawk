//
//  IssueCommentSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentSectionController: IGListBindingSectionController<IssueCommentModel>,
IGListBindingSectionControllerDataSource,
IGListBindingSectionControllerSelectionDelegate,
IssueCommentDetailCellDelegate,
IssueCommentReactionCellDelegate {

    private var collapsed = true
    private let client: GithubClient

    // set when sending a mutation and override the original issue query reactions
    private var reactionMutation: IssueCommentReactionViewModel? = nil

    init(client: GithubClient) {
        self.client = client
        super.init()
        dataSource = self
        selectionDelegate = self
        inset = UIEdgeInsets(top: 0, left: 0, bottom: Styles.Sizes.tableSectionSpacing, right: 0)
    }

    // MARK: Private API

    private func uncollapse() {
        guard collapsed else { return }
        collapsed = false
        // clear any collapse state before updating so we don't have a dangling overlay
        for cell in collectionContext?.visibleCells(for: self) ?? [] {
            if let cell = cell as? CollapsibleCell {
                cell.setCollapse(visible: false)
            }
        }
        update(animated: true)
    }

    private func react(content: ReactionContent, isAdd: Bool) {
        guard let id = object?.id else { return }
        client.react(subjectID: id, content: content, isAdd: isAdd) { result in
            if let result = result {
                self.reactionMutation = result
                self.update(animated: true)
            }
        }
    }

    // MARK: IGListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        viewModelsFor object: Any
        ) -> [IGListDiffable] {
        guard let object = self.object else { return [] }

        var bodies = [IGListDiffable]()
        for body in object.bodyModels {
            bodies.append(body)
            if collapsed && body === object.collapse?.model {
                break
            }
        }

        return [ object.details ]
            + bodies
            + [ reactionMutation ?? object.reactions ]
    }

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let context = self.collectionContext else { return .zero }
        let height: CGFloat
        if collapsed && (viewModel as AnyObject) === object?.collapse?.model {
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
        } else if viewModel is IssueCommentReactionViewModel {
            cellClass = IssueCommentReactionCell.self
        } else {
            cellClass = IssueCommentTextCell.self
        }
        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)
        if let cell = cell as? CollapsibleCell {
            cell.setCollapse(visible: collapsed && (viewModel as AnyObject) === object?.collapse?.model)
        }
        if let cell = cell as? IssueCommentDetailCell {
            cell.delegate = self
        }
        if let cell = cell as? IssueCommentReactionCell {
            cell.delegate = self
        }
        return cell
    }

    // MARK: IGListBindingSectionControllerSelectionDelegate

    func sectionController(
        _ sectionController: IGListBindingSectionController<IGListDiffable>,
        didSelectItemAt index: Int,
        viewModel: Any
        ) {
        switch viewModel {
        case is IssueCommentReactionViewModel,
             is IssueCommentDetailsViewModel: return
        default: break
        }
        uncollapse()
    }

    // MARK: IssueCommentDetailCellDelegate

    func didTapMore(cell: IssueCommentDetailCell) {

    }

    // MARK: IssueCommentReactionCellDelegate

    func didAdd(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        react(content: reaction, isAdd: true)
    }

    func didRemove(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        react(content: reaction, isAdd: false)
    }

}
