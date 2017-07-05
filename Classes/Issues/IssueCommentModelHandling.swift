//
//  IssueCommentModelHandling.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func BodyHeightForComment(viewModel: Any, width: CGFloat) -> CGFloat {
    if let viewModel = viewModel as? NSAttributedStringSizing {
        return viewModel.textViewSize(width).height
    } else if let viewModel = viewModel as? IssueCommentCodeBlockModel {
        let inset = IssueCommentCodeBlockCell.scrollViewInset
        return viewModel.contentSize.height + inset.top + inset.bottom
    } else if viewModel is IssueCommentImageModel {
        return 200.0
    } else if viewModel is IssueCommentReactionViewModel {
        return 40.0
    } else if viewModel is IssueCommentDetailsViewModel {
        return Styles.Sizes.rowSpacing * 3 + Styles.Sizes.avatar.height
    } else if let viewModel = viewModel as? IssueCommentQuoteModel {
        return viewModel.quote.textViewSize(width).height
    } else if viewModel is IssueCommentHrModel {
        return 3.0 + IssueCommentHrCell.inset.top + IssueCommentHrCell.inset.bottom
    } else {
        return Styles.Sizes.tableCellHeight
    }
}

func CellTypeForComment(viewModel: Any) -> AnyClass {
    switch viewModel {
    case is IssueCommentDetailsViewModel: return IssueCommentDetailCell.self
    case is IssueCommentReactionViewModel: return IssueCommentReactionCell.self
    case is IssueCommentImageModel: return IssueCommentImageCell.self
    case is IssueCommentCodeBlockModel: return IssueCommentCodeBlockCell.self
    case is IssueCommentSummaryModel: return IssueCommentSummaryCell.self
    case is IssueCommentQuoteModel: return IssueCommentQuoteCell.self
    case is IssueCommentUnsupportedModel: return IssueCommentUnsupportedCell.self
    case is IssueCommentHtmlModel: return IssueCommentHtmlCell.self
    case is IssueCommentHrModel: return IssueCommentHrCell.self
    case is NSAttributedStringSizing: return IssueCommentTextCell.self
    default: fatalError("Unhandled model: \(viewModel)")
    }
}

func ExtraCommentCellConfigure(
    cell: UICollectionViewCell,
    imageDelegate: IssueCommentImageCellDelegate,
    htmlDelegate: IssueCommentHtmlCellDelegate,
    attributedDelegate: AttributedStringViewDelegate
    ) {
    if let cell = cell as? IssueCommentImageCell {
        cell.delegate = imageDelegate
    } else if let cell = cell as? IssueCommentHtmlCell {
        cell.delegate = htmlDelegate
    } else if let cell = cell as? IssueCommentTextCell {
        cell.textView.delegate = attributedDelegate
    } else if let cell = cell as? IssueCommentQuoteCell {
        cell.textView.delegate = attributedDelegate
    }
}

