//
//  IssueCommentViewModelHeight.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/28/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func bodyHeight(viewModel: Any, width: CGFloat) -> CGFloat {
    if let viewModel = viewModel as? NSAttributedStringSizing {
        return viewModel.textViewSize(width).height
    } else if let viewModel = viewModel as? IssueCommentCodeBlockModel {
        let inset = IssueCommentCodeBlockCell.scrollViewInset
        return viewModel.code.textViewSize(0).height + inset.top + inset.bottom
    } else if viewModel is IssueCommentImageModel {
        return 200.0
    } else if viewModel is IssueCommentReactionViewModel {
        return 40.0
    } else if viewModel is IssueCommentDetailsViewModel {
        return Styles.Sizes.gutter * 2 + Styles.Sizes.avatar.height
    } else if let viewModel = viewModel as? IssueCommentQuoteModel {
        return viewModel.quote.textViewSize(width).height
    } else if viewModel is IssueCommentHrModel {
        return 3.0 + IssueCommentHrCell.inset.top + IssueCommentHrCell.inset.bottom
    } else {
        return Styles.Sizes.tableCellHeight
    }
}
