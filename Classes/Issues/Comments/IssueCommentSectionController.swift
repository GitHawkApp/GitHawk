//
//  IssueCommentSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import TUSafariActivity

final class IssueCommentSectionController: ListBindingSectionController<IssueCommentModel>,
    ListBindingSectionControllerDataSource,
    ListBindingSectionControllerSelectionDelegate,
    IssueCommentDetailCellDelegate,
IssueCommentReactionCellDelegate,
AttributedStringViewIssueDelegate,
EditCommentViewControllerDelegate,
DoubleTappableCellDelegate {

    private var collapsed = true
    private let generator = UIImpactFeedbackGenerator()
    private let client: GithubClient
    private let model: IssueDetailsModel
    private var hasBeenDeleted = false

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()
    private lazy var photoHandler: PhotoViewHandler = {
        return PhotoViewHandler(viewController: self.viewController)
    }()
    private lazy var imageCache: ImageCellHeightCache = {
        return ImageCellHeightCache(sectionController: self)
    }()

    // set when sending a mutation and override the original issue query reactions
    private var reactionMutation: IssueCommentReactionViewModel?

    // set after succesfully editing the body
    private var bodyEdits: (markdown: String, models: [ListDiffable])?

    private let tailModel = "tailModel" as ListDiffable

    init(model: IssueDetailsModel, client: GithubClient) {
        self.model = model
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

    func shareAction(sender: UIView) -> UIAlertAction? {
        let attribute = object?.asReviewComment == true ? "#discussion_r" : "#issuecomment-"
        guard let number = object?.number,
            let url = URL(string: "https://github.com/\(model.owner)/\(model.repo)/issues/\(model.number)\(attribute)\(number)")
        else { return nil }
        weak var weakSelf = self

        return AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf?.viewController })
            .share([url], activities: [TUSafariActivity()]) { $0.popoverPresentationController?.sourceView = sender }
    }

    func deleteAction() -> UIAlertAction? {
        guard object?.viewerCanDelete == true else { return nil }

        return AlertAction.delete { [weak self] _ in
            let title = NSLocalizedString("Are you sure?", comment: "")
            let message = NSLocalizedString("Deleting this comment is irreversible, do you want to continue?", comment: "")
            let alert = UIAlertController.configured(title: title, message: message, preferredStyle: .alert)

            alert.addActions([
                AlertAction.cancel(),
                AlertAction.delete { [weak self] _ in
                    self?.deleteComment()
                }
            ])

            self?.viewController?.present(alert, animated: true)
        }
    }

    func editAction() -> UIAlertAction? {
        guard object?.viewerCanUpdate == true else { return nil }
        return UIAlertAction(title: NSLocalizedString("Edit", comment: ""), style: .default, handler: { [weak self] _ in
            guard let markdown = self?.bodyEdits?.markdown ?? self?.object?.rawMarkdown,
                let issueModel = self?.model,
                let client = self?.client,
                let commentID = self?.object?.number,
                let isRoot = self?.object?.isRoot
                else { return }
            let edit = EditCommentViewController(
                client: client,
                markdown: markdown,
                issueModel: issueModel,
                commentID: commentID,
                isRoot: isRoot
            )
            edit.delegate = self
            let nav = UINavigationController(rootViewController: edit)
            nav.modalPresentationStyle = .formSheet
            self?.viewController?.present(nav, animated: true, completion: nil)
        })
    }

    private func clearCollapseCells() {
        // clear any collapse state before updating so we don't have a dangling overlay
        for cell in collectionContext?.visibleCells(for: self) ?? [] {
            if let cell = cell as? CollapsibleCell {
                cell.setCollapse(visible: false)
            }
        }
    }

    @discardableResult
    private func uncollapse() -> Bool {
        guard collapsed else { return false }
        collapsed = false
        clearCollapseCells()
        update(animated: true)
        return true
    }

    private func react(cell: IssueCommentReactionCell?, content: ReactionContent, isAdd: Bool) {
        guard let object = self.object else { return }

        let previousReaction = reactionMutation
        let result = IssueLocalReaction(
            fromServer: object.reactions,
            previousLocal: reactionMutation,
            content: content,
            add: isAdd
        )
        reactionMutation = result.viewModel

        cell?.perform(operation: result.operation, content: content)

        update(animated: true)
        generator.impactOccurred()
        client.react(subjectID: object.id, content: content, isAdd: isAdd) { [weak self] result in
            if result == nil {
                self?.reactionMutation = previousReaction
                self?.update(animated: true)
            }
        }
    }

    /// Deletes the comment and optimistically removes it from the feed
    private func deleteComment() {
        guard let number = object?.number else { return }

        // Optimistically delete the comment
        hasBeenDeleted = true
        update(animated: true, completion: nil)

        // Actually delete the comment now
        client.deleteComment(owner: model.owner, repo: model.repo, commentID: number) { [weak self] result in
            switch result {
            case .error:
                self?.hasBeenDeleted = false
                self?.update(animated: true, completion: nil)

                ToastManager.showGenericError()
            case .success: break // Don't need to handle success since updated optimistically
            }
        }
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = self.object else { return [] }
        guard !hasBeenDeleted else { return [] }

        var bodies = [ListDiffable]()
        let bodyModels = bodyEdits?.models ?? object.bodyModels
        for body in bodyModels {
            bodies.append(body)
            if collapsed && body === object.collapse?.model {
                break
            }
        }

        // if this is a PR comment, if this is the tail model, append an empty space cell at the end so there's a divider
        // otherwise append reactions
        let tail: [ListDiffable] = object.asReviewComment
            ? (object.threadState == .tail ? [tailModel] : [])
            : [ reactionMutation ?? object.reactions ]

        return [ object.details ]
            + bodies
            + tail
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width,
            let viewModel = viewModel as? ListDiffable
            else { fatalError("Collection context must be set") }

        let height: CGFloat
        if collapsed && (viewModel as AnyObject) === object?.collapse?.model {
            height = object?.collapse?.height ?? 0
        } else if viewModel is IssueCommentReactionViewModel {
            height = 40.0
        } else if viewModel is IssueCommentDetailsViewModel {
            height = Styles.Sizes.rowSpacing * 3 + Styles.Sizes.avatar.height
        } else if viewModel === tailModel {
            height = Styles.Sizes.rowSpacing
        } else {
            height = BodyHeightForComment(
                viewModel: viewModel,
                width: width,
                webviewCache: webviewCache,
                imageCache: imageCache
            )
        }

        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        guard let context = self.collectionContext,
            let viewModel = viewModel as? ListDiffable
            else { fatalError("Collection context must be set") }

        if viewModel === tailModel {
            guard let cell = context.dequeueReusableCell(of: IssueReviewEmptyTailCell.self, for: self, at: index) as? UICollectionViewCell & ListBindable
                else { fatalError("Cell not bindable") }
            return cell
        }

        let cellClass: AnyClass
        switch viewModel {
        case is IssueCommentDetailsViewModel: cellClass = IssueCommentDetailCell.self
        case is IssueCommentReactionViewModel: cellClass = IssueCommentReactionCell.self
        default: cellClass = CellTypeForComment(viewModel: viewModel)
        }

        guard let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError("Cell not bindable") }

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
            cell.configure(borderVisible: threadState == .single || threadState == .tail)
            cell.delegate = self
        }
        
        if let object = self.object,
            !object.asReviewComment,
            let cell = cell as? DoubleTappableCell {
            cell.doubleTapDelegate = self
        }

        ExtraCommentCellConfigure(
            cell: cell,
            imageDelegate: photoHandler,
            htmlDelegate: webviewCache,
            htmlNavigationDelegate: viewController,
            htmlImageDelegate: photoHandler,
            attributedDelegate: viewController,
            issueAttributedDelegate: self,
            imageHeightDelegate: imageCache
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
    
    // MARK: DoubleTappableCellDelegate
    
    func didDoubleTap(cell: DoubleTappableCell) {
        let reaction = ReactionContent.thumbsUp
        guard let reactions = reactionMutation ?? self.object?.reactions,
            !reactions.viewerDidReact(reaction: reaction)
            else { return }
        
        react(
            cell: collectionContext?.cellForItem(at: numberOfItems() - 1, sectionController: self) as? IssueCommentReactionCell,
            content: reaction,
            isAdd: true
        )
    }

    // MARK: IssueCommentDetailCellDelegate

    func didTapMore(cell: IssueCommentDetailCell, sender: UIView) {
        guard let login = object?.details.login else {
            ToastManager.showGenericError()
            return
        }

        let alertTitle = NSLocalizedString("%@'s comment", comment: "Used in an action sheet title, eg. \"Basthomas's comment\".")

        let alert = UIAlertController.configured(
            title: .localizedStringWithFormat(alertTitle, login),
            preferredStyle: .actionSheet
        )
        alert.popoverPresentationController?.sourceView = sender
        alert.addActions([
            shareAction(sender: sender),
            editAction(),
            deleteAction(),
            AlertAction.cancel()
        ])
        viewController?.present(alert, animated: true)
    }

    func didTapProfile(cell: IssueCommentDetailCell) {
        guard let login = object?.details.login else {
            ToastManager.showGenericError()
            return
        }

        viewController?.presentProfile(login: login)
    }

    // MARK: IssueCommentReactionCellDelegate

    func didAdd(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        // don't add a reaction if already reacted
        guard let reactions = reactionMutation ?? self.object?.reactions,
            !reactions.viewerDidReact(reaction: reaction)
            else { return }

        react(cell: cell, content: reaction, isAdd: true)
    }

    func didRemove(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        // don't remove a reaction if it doesn't exist
        guard let reactions = reactionMutation ?? self.object?.reactions,
            reactions.viewerDidReact(reaction: reaction)
            else { return }

        react(cell: cell, content: reaction, isAdd: false)
    }

    // MARK: AttributedStringViewIssueDelegate

    func didTapIssue(view: AttributedStringView, issue: IssueDetailsModel) {
        let controller = IssuesViewController(client: client, model: issue)
        viewController?.show(controller, sender: nil)
    }

    // MARK: EditCommentViewControllerDelegate

    func didEditComment(viewController: EditCommentViewController, markdown: String) {
        viewController.dismiss(animated: true)

        guard let width = collectionContext?.containerSize.width else { return }
        let options = commentModelOptions(owner: model.owner, repo: model.repo)
        let bodyModels = CreateCommentModels(markdown: markdown, width: width, options: options)
        bodyEdits = (markdown, bodyModels)
        collapsed = false
        clearCollapseCells()
        update(animated: true)
    }

    func didCancel(viewController: EditCommentViewController) {
        viewController.dismiss(animated: true)
    }

}
