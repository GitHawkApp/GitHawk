//
//  IssueCommentModelHandling.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledTextKit

func BodyHeightForComment(
    viewModel: Any,
    width: CGFloat,
    webviewCache: WebviewCellHeightCache?,
    imageCache: ImageCellHeightCache?
    ) -> CGFloat {
    if let viewModel = viewModel as? StyledTextRenderer {
        return viewModel.viewSize(in: width).height
    } else if let viewModel = viewModel as? IssueCommentCodeBlockModel {
        let inset = IssueCommentCodeBlockCell.scrollViewInset
        return viewModel.contentSize.height + inset.top + inset.bottom
    } else if let viewModel = viewModel as? IssueCommentImageModel {
        return imageCache?.height(model: viewModel, width: width) ?? 200
    } else if let viewModel = viewModel as? IssueCommentQuoteModel {
        return viewModel.string.viewSize(in: width).height
    } else if viewModel is IssueCommentHrModel {
        return 3.0 + IssueCommentHrCell.inset.top + IssueCommentHrCell.inset.bottom
    } else if let cache = webviewCache, let viewModel = viewModel as? IssueCommentHtmlModel {
        return cache.height(model: viewModel, width: width)
    } else if let viewModel = viewModel as? IssueCommentTableModel {
        return viewModel.size.height
    } else {
        return Styles.Sizes.tableCellHeight
    }
}

func CellTypeForComment(viewModel: Any) -> AnyClass {
    switch viewModel {
    case is IssueCommentImageModel: return IssueCommentImageCell.self
    case is IssueCommentCodeBlockModel: return IssueCommentCodeBlockCell.self
    case is IssueCommentSummaryModel: return IssueCommentSummaryCell.self
    case is IssueCommentQuoteModel: return IssueCommentQuoteCell.self
    case is IssueCommentUnsupportedModel: return IssueCommentUnsupportedCell.self
    case is IssueCommentHtmlModel: return IssueCommentHtmlCell.self
    case is IssueCommentHrModel: return IssueCommentHrCell.self
    case is StyledTextRenderer: return IssueCommentTextCell.self
    case is IssueCommentTableModel: return IssueCommentTableCell.self
    default: fatalError("Unhandled model: \(viewModel)")
    }
}

func ExtraCommentCellConfigure(
    cell: UICollectionViewCell,
    imageDelegate: IssueCommentImageCellDelegate?,
    htmlDelegate: IssueCommentHtmlCellDelegate?,
    htmlNavigationDelegate: IssueCommentHtmlCellNavigationDelegate?,
    htmlImageDelegate: IssueCommentHtmlCellImageDelegate?,
    markdownDelegate: MarkdownStyledTextViewDelegate?,
    imageHeightDelegate: IssueCommentImageHeightCellDelegate
    ) {
    if let cell = cell as? IssueCommentImageCell {
        cell.delegate = imageDelegate
        cell.heightDelegate = imageHeightDelegate
    } else if let cell = cell as? IssueCommentHtmlCell {
        cell.delegate = htmlDelegate
        cell.navigationDelegate = htmlNavigationDelegate
        cell.imageDelegate = htmlImageDelegate
    } else if let cell = cell as? IssueCommentTextCell {
        cell.textView.tapDelegate = markdownDelegate
    } else if let cell = cell as? IssueCommentQuoteCell {
        cell.delegate = markdownDelegate
    } else if let cell = cell as? IssueCommentTableCell {
        cell.delegate = markdownDelegate
    }
}
