//
//  IssueCommentTextCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentTextCell: UICollectionViewCell {

    static let inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)

    let textView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        textView.backgroundColor = .clear
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        contentView.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = contentView.bounds
    }

}

extension IssueCommentTextCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NSAttributedStringSizing else { return }
        viewModel.configure(textView: textView)
        textView.isEditable = false
        textView.isSelectable = true

        setNeedsLayout()
    }

}
