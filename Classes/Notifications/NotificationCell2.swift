//
//  NotificationCell2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import StyledTextKit

protocol NotificationCell2Delegate: class {
    func didTapRead(cell: NotificationCell2)
    func didTapWatch(cell: NotificationCell2)
    func didTapMore(cell: NotificationCell2, sender: UIView)
}

final class NotificationCell2: SelectableCell {

    public static let inset = UIEdgeInsets(
        top: NotificationCell2.topInset + NotificationCell2.headerHeight + Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: NotificationCell2.actionsHeight,
        right: Styles.Sizes.gutter
    )
    public static let topInset = Styles.Sizes.rowSpacing
    public static let headerHeight = ceil(Styles.Text.secondary.preferredFont.lineHeight)
    public static let actionsHeight = Styles.Sizes.gutter + 4*Styles.Sizes.rowSpacing

    private weak var delegate: NotificationCell2Delegate?
    private let iconImageView = UIImageView()
    private let dateLabel = ShowMoreDetailsLabel()
    private let detailsLabel = UILabel()
    private let textView = StyledTextView()
    private let stackView = UIStackView()
    private let commentButton = UIButton()
    private let readButton = UIButton()
    private let watchButton = UIButton()
    private let moreButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        backgroundColor = .white

        contentView.addSubview(iconImageView)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(textView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(commentButton)
        stackView.addArrangedSubview(watchButton)
        stackView.addArrangedSubview(readButton)
        stackView.addArrangedSubview(moreButton)

        let grey = Styles.Colors.Gray.light.color
        let font = Styles.Text.secondary.preferredFont
        let inset = NotificationCell2.inset
        let actionsHeight = NotificationCell2.actionsHeight

        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(inset.top)
            make.centerX.equalTo(inset.left / 2)
        }

        dateLabel.font = font
        dateLabel.textColor = grey
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(NotificationCell2.topInset)
            make.right.equalTo(-inset.right)
        }

        detailsLabel.lineBreakMode = .byTruncatingMiddle
        detailsLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.rowSpacing)
            make.left.equalTo(NotificationCell.labelInset.left)
            make.right.lessThanOrEqualTo(dateLabel.snp.left).offset(-Styles.Sizes.columnSpacing)
        }

        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.snp.makeConstraints { make in
            make.left.equalTo(inset.left)
            make.right.equalTo(-inset.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(actionsHeight)
        }

        commentButton.titleLabel?.font = font
        commentButton.isUserInteractionEnabled = false
        commentButton.tintColor = grey
        commentButton.setTitleColor(grey, for: .normal)
        commentButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
        commentButton.titleEdgeInsets = UIEdgeInsets(top: -4, left: 2, bottom: 0, right: 0)
        commentButton.setImage(UIImage(named: "comment-small")?.withRenderingMode(.alwaysTemplate), for: .normal)
        commentButton.contentHorizontalAlignment = .left
        commentButton.snp.makeConstraints { make in
            make.width.equalTo(actionsHeight)
        }

        watchButton.tintColor = grey
        watchButton.addTarget(self, action: #selector(onWatch(sender:)), for: .touchUpInside)
        watchButton.contentHorizontalAlignment = .center
        watchButton.snp.makeConstraints { make in
            make.width.equalTo(actionsHeight)
        }

        readButton.tintColor = grey
        readButton.setImage(UIImage(named: "check-small")?.withRenderingMode(.alwaysTemplate), for: .normal)
        readButton.addTarget(self, action: #selector(onRead(sender:)), for: .touchUpInside)
        readButton.contentHorizontalAlignment = .center
        readButton.snp.makeConstraints { make in
            make.width.equalTo(actionsHeight)
        }

        moreButton.tintColor = grey
        moreButton.setImage(UIImage(named: "bullets-small")?.withRenderingMode(.alwaysTemplate), for: .normal)
        moreButton.addTarget(self, action: #selector(onMore(sender:)), for: .touchUpInside)
        moreButton.contentHorizontalAlignment = .right
        moreButton.snp.makeConstraints { make in
            make.width.equalTo(actionsHeight)
        }

        contentView.addBorder(.bottom, left: inset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textView.reposition(for: contentView.bounds.width)
    }

    override var accessibilityLabel: String? {
        get { return AccessibilityHelper.generatedLabel(forCell: self)}
        set {}
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    public func configure(with model: NotificationViewModel2, delegate: NotificationCell2Delegate?) {
        textView.configure(with: model.title, width: contentView.bounds.width)
        dateLabel.setText(date: model.date, format: .short)
        self.delegate = delegate

        var titleAttributes = [
            NSAttributedStringKey.font: Styles.Text.title.preferredFont,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.light.color
        ]
        let title = NSMutableAttributedString(string: "\(model.owner)/\(model.repo) ", attributes: titleAttributes)
        titleAttributes[NSAttributedStringKey.font] = Styles.Text.secondary.preferredFont
        switch model.ident {
        case .number(let number): title.append(NSAttributedString(string: "#\(number)", attributes: titleAttributes))
        default: break
        }
        detailsLabel.attributedText = title

        let tintColor: UIColor
        switch model.state {
        case .closed: tintColor = Styles.Colors.Red.medium.color
        case .merged: tintColor = Styles.Colors.purple.color
        case .open: tintColor = Styles.Colors.Green.medium.color
        case .pending: tintColor = Styles.Colors.Blue.medium.color
        }
        iconImageView.tintColor = tintColor
        iconImageView.image = model.type.icon.withRenderingMode(.alwaysTemplate)

        let hasComments = model.comments > 0
        commentButton.alpha = hasComments ? 1 : 0.3
        commentButton.setTitle(hasComments ? model.comments.abbreviated : "", for: .normal)

        let watchingImageName = model.watching ? "mute" : "unmute"
        watchButton.setImage(UIImage(named: "\(watchingImageName)-small")?.withRenderingMode(.alwaysTemplate), for: .normal)

        contentView.alpha = model.read ? 0.5 : 1
    }

    @objc func onRead(sender: UIView) {
        delegate?.didTapRead(cell: self)
    }

    @objc func onWatch(sender: UIView) {
        delegate?.didTapWatch(cell: self)
    }

    @objc func onMore(sender: UIView) {
        delegate?.didTapMore(cell: self, sender: sender)
    }

}
