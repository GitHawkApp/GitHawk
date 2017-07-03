//
//  IssueCommentSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import NYTPhotoViewer
import SafariServices

final class IssueCommentSectionController: ListBindingSectionController<IssueCommentModel>,
    ListBindingSectionControllerDataSource,
    ListBindingSectionControllerSelectionDelegate,
    IssueCommentDetailCellDelegate,
    IssueCommentReactionCellDelegate,
    IssueCommentImageCellDelegate,
    NYTPhotosViewControllerDelegate,
    IssueCommentHtmlCellDelegate,
AttributedStringViewDelegate {

    private var collapsed = true
    private let client: GithubClient
    private var htmlSizes = [String: CGSize]()

    // set when sending a mutation and override the original issue query reactions
    private var reactionMutation: IssueCommentReactionViewModel? = nil

    private weak var referenceImageView: UIImageView? = nil

    init(client: GithubClient) {
        self.client = client
        super.init()
        dataSource = self
        selectionDelegate = self
    }

    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)

        // set the inset based on whether or not this is part of a comment thread
        guard let object = self.object else { return }
        switch object.threadState {
        case .single:
            inset = Styles.Sizes.listInsetLarge
        case .head:
            inset = Styles.Sizes.listInsetLargeHead
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

    private func open(url: URL) {
        let safari = SFSafariViewController(url: url)
        viewController?.present(safari, animated: true)
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
        } else if let viewModel = viewModel as? IssueCommentHtmlModel,
            let size = htmlSizes[viewModel.html] {
            height = size.height
        } else {
            height = bodyHeight(viewModel: viewModel, width: width)
        }

        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = self.collectionContext else { fatalError("Collection context must be set") }

        // cell class based on view model type
        let cellClass: AnyClass
        switch viewModel {
        case is IssueCommentDetailsViewModel: cellClass = IssueCommentDetailCell.self
        case is IssueCommentImageModel: cellClass = IssueCommentImageCell.self
        case is IssueCommentCodeBlockModel: cellClass = IssueCommentCodeBlockCell.self
        case is IssueCommentSummaryModel: cellClass = IssueCommentSummaryCell.self
        case is IssueCommentReactionViewModel: cellClass = IssueCommentReactionCell.self
        case is IssueCommentQuoteModel: cellClass = IssueCommentQuoteCell.self
        case is IssueCommentUnsupportedModel: cellClass = IssueCommentUnsupportedCell.self
        case is IssueCommentHtmlModel: cellClass = IssueCommentHtmlCell.self
        case is IssueCommentHrModel: cellClass = IssueCommentHrCell.self
        case is NSAttributedStringSizing: cellClass = IssueCommentTextCell.self
        default: fatalError("Unhandled view model: \(viewModel)")
        }

        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)

        // extra config outside of bind API. applies to multiple cell types.
        if let cell = cell as? CollapsibleCell {
            cell.setCollapse(visible: collapsed && (viewModel as AnyObject) === object?.collapse?.model)
        }

        // connect specific cell delegates
        if let cell = cell as? IssueCommentDetailCell {
            let threadState = object?.threadState
            let showBorder = threadState == .single || threadState == .head
            cell.setBorderVisible(showBorder)
            cell.delegate = self
        } else if let cell = cell as? IssueCommentReactionCell {
            let threadState = object?.threadState
            let showBorder = threadState == .single || threadState == .tail
            cell.setBorderVisible(showBorder)
            cell.delegate = self
        } else if let cell = cell as? IssueCommentImageCell {
            cell.delegate = self
        } else if let cell = cell as? IssueCommentHtmlCell {
            cell.delegate = self
        } else if let cell = cell as? IssueCommentTextCell {
            cell.textView.delegate = self
        } else if let cell = cell as? IssueCommentQuoteCell {
            cell.textView.delegate = self
        }

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
        viewController?.present(CreateProfileViewController(login: login), animated: true)
    }

    // MARK: IssueCommentReactionCellDelegate

    func didAdd(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        react(content: reaction, isAdd: true)
    }

    func didRemove(cell: IssueCommentReactionCell, reaction: ReactionContent) {
        react(content: reaction, isAdd: false)
    }

    // MARK: IssueCommentImageCellDelegate

    func didTapImage(cell: IssueCommentImageCell, image: UIImage) {
        referenceImageView = cell.imageView
        let photo = IssueCommentPhoto(image: image)
        let photosViewController = NYTPhotosViewController(photos: [photo])
        photosViewController.delegate = self
        viewController?.present(photosViewController, animated: true)
    }

    // MARK: NYTPhotosViewControllerDelegate

    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        return referenceImageView
    }

    // MARK: IssueCommentHtmlCellDelegate

    func webViewDidLoad(cell: IssueCommentHtmlCell, html: String) {
        guard htmlSizes[html] == nil else { return }
        htmlSizes[html] = cell.webViewPreferredSize()
        UIView.performWithoutAnimation {
            self.collectionContext?.invalidateLayout(for: self)
        }
    }

    func webViewWantsNavigate(cell: IssueCommentHtmlCell, url: URL) {
        open(url: url)
    }

    // MARK: AttributedStringViewDelegate

    func didTapURL(view: AttributedStringView, url: URL) {
        open(url: url)
    }

}

