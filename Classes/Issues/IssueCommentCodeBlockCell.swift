//
//  IssueCommentCodeBlockCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class IssueCommentCodeBlockCell: UICollectionViewCell {

    static let inset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    let textView = UITextView()
    let scrollView = UIScrollView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        scrollView.backgroundColor = Styles.Colors.Gray.lighter
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        textView.backgroundColor = .clear
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        scrollView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension IssueCommentCodeBlockCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentCodeBlockModel else { return }
        viewModel.code.configure(textView: textView)
        textView.isEditable = false
        textView.isSelectable = true
        scrollView.contentSize = viewModel.code.textViewSize
    }

}
