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

    let textView = UITextView()
    let scrollView = UIScrollView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        scrollView.backgroundColor = Styles.Colors.Gray.lighter
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        scrollView.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = scrollView.bounds
    }

}

extension IssueCommentCodeBlockCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentCodeBlockModel else { return }
        viewModel.code.configure(textView: textView)
        scrollView.contentSize = viewModel.code.textViewSize
    }

}
