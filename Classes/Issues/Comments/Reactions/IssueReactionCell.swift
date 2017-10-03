//
//  IssueReactionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueReactionCell: UICollectionViewCell {

    private let emojiLabel = UILabel()
    private let countLabel = ShowMoreDetailsLabel()
    private var detailText = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        let offset: CGFloat = 6

        emojiLabel.textAlignment = .center
        emojiLabel.backgroundColor = .clear
        // hint bigger emoji than labels
        emojiLabel.font = UIFont.systemFont(ofSize: Styles.Sizes.Text.body + 2)
        contentView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView).offset(-offset)
        }

        countLabel.textAlignment = .center
        countLabel.backgroundColor = .clear
        countLabel.font = Styles.Fonts.body
        countLabel.textColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(emojiLabel)
            make.left.equalTo(emojiLabel.snp.right).offset(offset)
        }

        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(IssueReactionCell.showMenu(recognizer:))
        )
        isUserInteractionEnabled = true
        addGestureRecognizer(longPress)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // required for UIMenuController
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(IssueReactionCell.empty)
    }

    // MARK: Public API

    func configure(emoji: String, count: Int, detail: String, isViewer: Bool) {
        emojiLabel.text = emoji
        countLabel.text = "\(count)"
        detailText = detail
        contentView.backgroundColor = isViewer ? Styles.Colors.Blue.light.color : .clear
        accessibilityHint = isViewer
            ? NSLocalizedString("Tap to remove your reaction", comment: "")
            : NSLocalizedString("Tap to react with this emoji", comment: "")
    }

    func popIn() {
        emojiLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        emojiLabel.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [.curveEaseInOut], animations: {
            self.emojiLabel.transform = .identity
            self.emojiLabel.alpha = 1
        })

        countLabel.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.countLabel.alpha = 1
        })
    }

    func pullOut(completion: @escaping (Bool) -> ()) {
        // hack to prevent changing to "0"
        countLabel.text = "1"

        countLabel.alpha = 1
        emojiLabel.transform = .identity
        emojiLabel.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.countLabel.alpha = 0
            self.emojiLabel.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self.emojiLabel.alpha = 0
        }, completion: completion)
    }

    func iterate(add: Bool) {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionPush
        animation.subtype = add ? kCATransitionFromTop : kCATransitionFromBottom
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        countLabel.layer.add(animation, forKey: "text-change")
    }

    // MARK: Private API

    func showMenu(recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .began,
            detailText.characters.count > 0 else { return }

        becomeFirstResponder()

        let menu = UIMenuController.shared
        menu.menuItems = [
            UIMenuItem(title: detailText, action: #selector(IssueReactionCell.empty))
        ]
        menu.setTargetRect(contentView.bounds, in: self)
        menu.setMenuVisible(true, animated: true)
    }

    func empty() {}

    // MARK: Accessibility

    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { "\($0 ?? "").\n\($1)" })
        }
        set { }
    }
    
}
