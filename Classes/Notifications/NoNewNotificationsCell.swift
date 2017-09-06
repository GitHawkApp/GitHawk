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

    let emoji = UILabel()
    let label = UILabel()
    let shadow = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        emoji.text = "🎉"
        emoji.textAlignment = .center
        emoji.backgroundColor = .clear
        emoji.font = UIFont.systemFont(ofSize: 60)
        contentView.addSubview(emoji)
        emoji.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView).offset(-Styles.Sizes.tableSectionSpacing)
        }

        shadow.fillColor = UIColor(white: 0, alpha: 0.05).cgColor
        contentView.layer.addSublayer(shadow)

        label.text = NSLocalizedString("Inbox zero!", comment: "")
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = Styles.Fonts.body
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(emoji)
            make.top.equalTo(emoji.snp.bottom).offset(Styles.Sizes.tableSectionSpacing)
        }

        resetAnimations()

        // CAAnimations will be removed from layers on background. restore when foregrounding.
        NotificationCenter.default
            .addObserver(self,
                selector: #selector(NoNewNotificationsCell.resetAnimations),
                name: NSNotification.Name.UIApplicationWillEnterForeground,
                object: nil
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let width: CGFloat = 30
        let height: CGFloat = 12
        shadow.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: CGSize(width: width, height: height))).cgPath
        shadow.position = CGPoint(x: contentView.bounds.width/2 - 20, y: contentView.bounds.height/2 + 5)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetAnimations()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        resetAnimations()
    }

    // MARK: Private API

    @objc private func resetAnimations() {
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let duration: TimeInterval = 1

        let emojiBounce = CABasicAnimation(keyPath: "transform.translation.y")
        emojiBounce.toValue = -10
        emojiBounce.repeatCount = Float.greatestFiniteMagnitude
        emojiBounce.autoreverses = true
        emojiBounce.duration = duration
        emojiBounce.timingFunction = timingFunction

        emoji.layer.add(emojiBounce, forKey: "nonewnotificationscell.emoji")

        let shadowScale = CABasicAnimation(keyPath: "transform.scale")
        shadowScale.toValue = 0.9
        shadowScale.repeatCount = Float.greatestFiniteMagnitude
        shadowScale.autoreverses = true
        shadowScale.duration = duration
        shadowScale.timingFunction = timingFunction

        shadow.add(shadowScale, forKey: "nonewnotificationscell.shadow")
    }

}
