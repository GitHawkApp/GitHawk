//
//  IssueNewCommentTextViewCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol IssueNewCommentTextViewCellDelegate: class {
    func didChangeText(cell: IssueNewCommentTextViewCell, text: String)
    func didChangeHeight(cell: IssueNewCommentTextViewCell, height:CGFloat)
    func didTapSend(cell: IssueNewCommentTextViewCell)
}

final class IssueNewCommentTextViewCell: UICollectionViewCell, UITextViewDelegate {

    static let bottomBarHeight: CGFloat = Styles.Sizes.tableCellHeight
    weak var delegate: IssueNewCommentTextViewCellDelegate? = nil

    private let textViewInsets = UIEdgeInsets(
        top: Styles.Sizes.gutter,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.gutter,
        right: Styles.Sizes.gutter
    )
    private let sendButton = UIButton()
    private let placeholderLabel = UILabel()
    private let textView = UITextView()
    private let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private let overlay = UIView()
    private var previousHeight: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.addSubview(textView)

        placeholderLabel.textColor = Styles.Colors.Gray.light.color
        placeholderLabel.text = NSLocalizedString("Leave a comment", comment: "")
        placeholderLabel.sizeToFit()
        placeholderLabel.font = Styles.Fonts.body
        contentView.addSubview(placeholderLabel)

        textView.contentInset = .zero
        textView.textContainerInset = textViewInsets
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = Styles.Fonts.body
        textView.backgroundColor = .clear
        textView.inputAccessoryView = CommentFormatterAccessoryView(textView: textView)

        contentView.addSubview(textView)

        sendButton.setTitle(NSLocalizedString("Comment", comment: ""), for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.backgroundColor = Styles.Colors.Green.medium.color
        sendButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: Styles.Sizes.columnSpacing, bottom: 4, right: Styles.Sizes.columnSpacing)
        sendButton.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        sendButton.titleLabel?.font = Styles.Fonts.button
        sendButton.addTarget(self, action: #selector(IssueNewCommentTextViewCell.onSend), for: .touchUpInside)
        contentView.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.bottom.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
        }

        overlay.isHidden = true
        overlay.backgroundColor = .white
        overlay.alpha = 0.7
        contentView.addSubview(overlay)
        overlay.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        overlay.addSubview(activity)
        activity.snp.makeConstraints { make in
            make.center.equalTo(overlay)
        }

        contentView.addBorder(.top)
        contentView.addBorder(.bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = contentView.bounds
        frame.size.height -= IssueNewCommentTextViewCell.bottomBarHeight
        textView.frame = frame

        var placeholderFrame = placeholderLabel.frame
        // extra inset past the selected range indicator
        placeholderFrame.origin.x = textViewInsets.left + 7
        placeholderFrame.origin.y = textViewInsets.top - 1
        placeholderLabel.frame = placeholderFrame
    }

    // MARK: Public API

    func configure(_ draft: String) {
        textView.text = draft
        updateTextState()
    }

    func setSending(sending: Bool) {
        overlay.isHidden = !sending

        if sending {
            textView.resignFirstResponder()
            activity.startAnimating()
        }
    }

    // MARK: Private API

    private var hasText: Bool {
        return textView.text.characters.count > 0
    }

    private func updateTextState() {
        let hasText = self.hasText
        sendButton.isEnabled = hasText
        sendButton.alpha = hasText ? 1 : 0.5
        placeholderLabel.isHidden = hasText
    }

    @objc private func onSend() {
        delegate?.didTapSend(cell: self)
    }

    // MARK: UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
        updateTextState()

        delegate?.didChangeText(cell: self, text: textView.text)

        let height = textView.sizeThatFits(CGSize(width: contentView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        if height != previousHeight {
            var frame = textView.frame
            frame.size.height = height
            textView.frame = frame

            previousHeight = height
            delegate?.didChangeHeight(cell: self, height: height)
        }
    }

}
