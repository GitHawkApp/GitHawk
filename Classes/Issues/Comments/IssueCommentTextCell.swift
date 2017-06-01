//
//  IssueCommentTextCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol IssueCommentTextCellDelegate: class {

}

final class IssueCommentTextCell: UICollectionViewCell {

    static let inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)

    weak var delegate: IssueCommentTextCellDelegate? = nil
    let label = UILabel()
    let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true

        label.numberOfLines = 0
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        LayoutCollapsible(layer: overlay, view: contentView)
    }

}

extension IssueCommentTextCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NSAttributedStringSizing else { return }
        label.attributedText = viewModel.attributedText
        let contentSize = viewModel.textViewSize
        let textFrame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        label.frame = UIEdgeInsetsInsetRect(textFrame, IssueCommentTextCell.inset)
    }

}

extension IssueCommentTextCell: CollapsibleCell {

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }
    
}
