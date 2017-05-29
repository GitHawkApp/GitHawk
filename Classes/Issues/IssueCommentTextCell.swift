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

    func didTap(commentTextCell: IssueCommentTextCell)

}

final class IssueCommentTextCell: UICollectionViewCell {

    static let inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)

    weak var delegate: IssueCommentTextCellDelegate? = nil
    let textView = UITextView()
    let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true

        textView.backgroundColor = .clear
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        contentView.addSubview(textView)

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(IssueCommentTextCell.didTapTextView(sender:))
        )
        textView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        LayoutCollapsible(layer: overlay, view: contentView)
    }

    // Mark: Private API

    @objc private func didTapTextView(sender: Any) {
        delegate?.didTap(commentTextCell: self)
    }

}

extension IssueCommentTextCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NSAttributedStringSizing else { return }
        viewModel.configure(textView: textView)
        textView.isEditable = false
        textView.isSelectable = true
        textView.frame = CGRect(
            x: 0,
            y: 0,
            width: viewModel.textViewSize.width,
            height: viewModel.textViewSize.height
        )
    }

}

extension IssueCommentTextCell: CollapsibleCell {

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }
    
}
