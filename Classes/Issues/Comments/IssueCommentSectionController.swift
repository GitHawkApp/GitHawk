//
//  IssueCommentSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentSectionController: ListBindingSectionController<IssueCommentModel>,
    ListBindingSectionControllerDataSource,
    ListBindingSectionControllerSelectionDelegate,
    IssueCommentDetailCellDelegate,
IssueCommentReactionCellDelegate {

    private var collapsed = true
    private let client: GithubClient

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()
    private lazy var photoHandler: PhotoViewHandler = {
        return PhotoViewHandler(viewController: self.viewController)
    }()

    // set when sending a mutation and override the original issue query reactions
    private var reactionMutation: IssueCommentReactionViewModel? = nil

    init(client: GithubClient) {
        self.client = client
        super.init()
        self.dataSource = self
        self.selectionDelegate = self
    }

    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)

        // set the inset based on whether or not this is part of a comment thread
        guard let object = self.object else { return }
        switch object.threadState {
        case .single:
            inset = Styles.Sizes.listInsetLarge
        case .neck:
            inset = .zero
        case .tail:
            inset = Styles.Sizes.listInsetLargeTail
        }
    }

    // MARK: Private API

    @discardableResult
    private func uncollapse() -> Bool {
        guard collapsed else { return false }
        collapsed = false
        // clear any collapse state before updating so we don't have a dangling overlay
        for cell in collectionContext?.visibleCells(for: self) ?? [] {
            if let cell = cell as? CollapsibleCell {
                cell.setCollapse(visible: false)
            }
        }
        update(animated: true)
        return true
    }

    private func react(content: ReactionContent, isAdd: Bool) {
        guard let id = object?.id else { return }
        client.react(subjectID: id, content: content, isAdd: isAdd) { [weak self] result in
            if let result = result {
                self?.reactionMutation = result
                self?.update(animated: true)
            }
        }
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = self.object else { return [] }

        var bodies = [ListDiffable]()
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
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Collection context must be set") }

        let height: CGFloat
        if collapsed && (viewModel as AnyObject) === object?.collapse?.model {
            height = object?.collapse?.height ?? 0
        } else if viewModel is IssueCommentReactionViewModel {
            height = 40.0
        } else if viewModel is IssueCommentDetailsViewModel {
            height = Styles.Sizes.rowSpacing * 3 + Styles.Sizes.avatar.height
        } else {
            height = BodyHeightForComment(viewModel: viewModel, width: width)
        }

        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = self.collectionContext else { fatalError("Collection context must be set") }

        let cellClass: AnyClass
        switch viewModel {
        case is IssueCommentDetailsViewModel: cellClass = IssueCommentDetailCell.self
        case is IssueCommentReactionViewModel: cellClass = IssueCommentReactionCell.self
        default: cellClass = CellTypeForComment(viewModel: viewModel)
        }
        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)

        // extra config outside of bind API. applies to multiple cell types.
        if let cell = cell as? CollapsibleCell {
            cell.setCollapse(visible: collapsed && (viewModel as AnyObject) === object?.collapse?.model)
        }

        // connect specific cell delegates
        if let cell = cell as? IssueCommentDetailCell {
            cell.setBorderVisible(object?.threadState == .single)
            cell.delegate = self
        } else if let cell = cell as? IssueCommentReactionCell {
            let threadState = object?.threadState
            let showBorder = threadState == .single || threadState == .tail
            cell.setBorderVisible(showBorder)
            cell.delegate = self
        }

        ExtraCommentCellConfigure(
            cell: cell,
            imageDelegate: photoHandler,
            htmlDelegate: webviewCache,
            htmlNavigationDelegate: viewController,
            attributedDelegate: viewController
        )

        return cell
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
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

    func didTapMore(cell: IssueCommentDetailCell) {}

    func didTapProfile(cell: IssueCommentDetailCell) {
        guard let login = object?.details.login else { return }
        viewController?.presentProfile(login: login)
    }

    // MARK: IssueCommentReactionCellDelegate

    func didAdd(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        react(content: reaction, isAdd: true)
    }

    func didRemove(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        react(content: reaction, isAdd: false)
    }

}



