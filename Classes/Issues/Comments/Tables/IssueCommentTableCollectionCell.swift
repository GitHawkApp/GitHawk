//
//  IssueCommentTableCollectionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol IssueCommentTableCollectionCellDelegate: class {
    func didTapURL(cell: IssueCommentTableCollectionCell, url: URL)
    func didTapUsername(cell: IssueCommentTableCollectionCell, username: String)
}

final class IssueCommentTableCollectionCell: UICollectionViewCell, AttributedStringViewDelegate {

    weak var delegate: IssueCommentTableCollectionCellDelegate? = nil

    private let textView = AttributedStringView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public API

    func configure(_ model: NSAttributedStringSizing) {
        textView.configureAndSizeToFit(text: model, width: 0)
    }

    // MARK: AttributedStringViewDelegate

    func didTapURL(view: AttributedStringView, url: URL) {
        delegate?.didTapURL(cell: self, url: url)
    }

    func didTapUsername(view: AttributedStringView, username: String) {
        delegate?.didTapUsername(cell: self, username: username)
    }

}
