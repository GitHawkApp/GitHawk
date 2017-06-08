//
//  IssueCommentViewModelHeight.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/28/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func bodyHeight(viewModel: Any) -> CGFloat {
    if let viewModel = viewModel as? NSAttributedStringSizing {
        return viewModel.textViewSize.height
    } else if let viewModel = viewModel as? IssueCommentCodeBlockModel {
        return viewModel.code.textViewSize.height
    } else if viewModel is IssueCommentImageModel {
        return 200.0
    } else if viewModel is IssueCommentReactionViewModel {
        return 40.0
    } else {
        return Styles.Sizes.tableCellHeight
    }
}
