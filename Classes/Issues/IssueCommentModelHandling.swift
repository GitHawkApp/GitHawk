//
//  IssueCommentModelHandling.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func BodyHeightForComment(
    viewModel: Any,
    width: CGFloat,
    webviewCache: WebviewCellHeightCache?,
    imageCache: ImageCellHeightCache?
    ) -> CGFloat {
    if let viewModel = viewModel as? NSAttributedStringSizing {
        return viewModel.textViewSize(width).height
    } else if let viewModel = viewModel as? IssueCommentCodeBlockModel {
        let inset = IssueCommentCodeBlockCell.scrollViewInset
        return viewModel.contentSize.height + inset.top + inset.bottom
    } else if let viewModel = viewModel as? IssueCommentImageModel {
        return imageCache?.height(model: viewModel, width: width) ?? 200
    } else if let viewModel = viewModel as? IssueCommentQuoteModel {
        return viewModel.quote.textViewSize(width).height
    } else if viewModel is IssueCommentHrModel {
        return 3.0 + IssueCommentHrCell.inset.top + IssueCommentHrCell.inset.bottom
    } else if let cache = webviewCache, let viewModel = viewModel as? IssueCommentHtmlModel {
        return cache.height(model: viewModel, width: width)
    } else if let viewModel = viewModel as? IssueCommentTableModel {
        let inset = IssueCommentTableCell.inset
        return viewModel.rowHeights.reduce(0) { $0 + $1 } + inset.top + inset.bottom
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
    case is NSAttributedStringSizing: return IssueCommentTextCell.self
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
    attributedDelegate: AttributedStringViewDelegate?,
    extrasAttributedDelegate: AttributedStringViewExtrasDelegate?,
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
        cell.textView.delegate = attributedDelegate
        cell.textView.extrasDelegate = extrasAttributedDelegate
    } else if let cell = cell as? IssueCommentQuoteCell {
        cell.textView.delegate = attributedDelegate
    } else if let cell = cell as? IssueCommentTableCell {
        cell.delegate = attributedDelegate
    }
}
