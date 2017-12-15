//
//  NoNewNotificationsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class NoNewNotificationsCell: UICollectionViewCell {

    let emojiLabel = UILabel()
    let messageLabel = UILabel()
    let shadow = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        emojiLabel.isAccessibilityElement = false
        emojiLabel.text = "🎉"
        emojiLabel.textAlignment = .center
        emojiLabel.backgroundColor = .clear
        emojiLabel.font = .systemFont(ofSize: 60)
        contentView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView).offset(-Styles.Sizes.tableSectionSpacing)
        }

        shadow.fillColor = UIColor(white: 0, alpha: 0.05).cgColor
        contentView.layer.addSublayer(shadow)

        messageLabel.isAccessibilityElement = false
        messageLabel.text = NSLocalizedString("Inbox zero!", comment: "")
        messageLabel.textAlignment = .center
        messageLabel.backgroundColor = .clear
        messageLabel.font = Styles.Text.body.preferredFont
        messageLabel.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emojiLabel)
            make.top.equalTo(emojiLabel.snp.bottom).offset(Styles.Sizes.tableSectionSpacing)
        }

        resetAnimations()

        // CAAnimations will be removed from layers on background. restore when foregrounding.
        NotificationCenter.default
            .addObserver(self,
                selector: #selector(NoNewNotificationsCell.resetAnimations),
                name: NSNotification.Name.UIApplicationWillEnterForeground,
                object: nil
        )

        contentView.isAccessibilityElement = true
        contentView.accessibilityLabel = NSLocalizedString("You have no new notifications!", comment: "Inbox Zero Accessibility Label")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()

        let width: CGFloat = 30
        let height: CGFloat = 12
        let rect = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        shadow.path = UIBezierPath(ovalIn: rect).cgPath

        let bounds = contentView.bounds
        shadow.bounds = rect
        shadow.position = CGPoint(
            x: bounds.width/2,
            y: bounds.height/2 + 15
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetAnimations()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        resetAnimations()
    }

    // MARK: Public API

    func configure(emoji: String, message: String) {
        emojiLabel.text = emoji
        messageLabel.text = message
    }

    // MARK: Private API

    @objc private func resetAnimations() {
        guard trueUnlessReduceMotionEnabled else { return }
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let duration: TimeInterval = 1

        let emojiBounce = CABasicAnimation(keyPath: "transform.translation.y")
        emojiBounce.toValue = -10
        emojiBounce.repeatCount = .greatestFiniteMagnitude
        emojiBounce.autoreverses = true
        emojiBounce.duration = duration
        emojiBounce.timingFunction = timingFunction

        emojiLabel.layer.add(emojiBounce, forKey: "nonewnotificationscell.emoji")

        let shadowScale = CABasicAnimation(keyPath: "transform.scale")
        shadowScale.toValue = 0.9
        shadowScale.repeatCount = .greatestFiniteMagnitude
        shadowScale.autoreverses = true
        shadowScale.duration = duration
        shadowScale.timingFunction = timingFunction

        shadow.add(shadowScale, forKey: "nonewnotificationscell.shadow")
    }

}
