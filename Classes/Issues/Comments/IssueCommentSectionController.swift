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
        inset = Styles.Sizes.listInsetLarge
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
        client.react(subjectID: id, content: content, isAdd: isAdd) { result in
            if let result = result {
                self.reactionMutation = result
                self.update(animated: true)
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
            else { return .zero }

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
        guard let context = self.collectionContext else { return UICollectionViewCell() }

        // cell class based on view model type
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
        } else if viewModel is IssueCommentQuoteModel {
            cellClass = IssueCommentQuoteCell.self
        } else if viewModel is IssueCommentUnsupportedModel {
            cellClass = IssueCommentUnsupportedCell.self
        } else if viewModel is IssueCommentHtmlModel {
            cellClass = IssueCommentHtmlCell.self
        } else if viewModel is IssueCommentHrModel {
            cellClass = IssueCommentHrCell.self
        } else {
            cellClass = IssueCommentTextCell.self
        }

        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)

        // extra config outside of bind API
        if let cell = cell as? CollapsibleCell {
            cell.setCollapse(visible: collapsed && (viewModel as AnyObject) === object?.collapse?.model)
        }

        if let cell = cell as? IssueCommentDetailCell {
            cell.delegate = self
        } else if let cell = cell as? IssueCommentReactionCell {
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


