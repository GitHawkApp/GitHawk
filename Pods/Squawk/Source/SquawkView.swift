//
//  SquawkView.swift
//  Squawk
//
//  Created by Ryan Nystrom on 7/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

internal final class SquawkView: UIView {

    weak var delegate: SquawkViewDelegate?

    let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let label = UILabel()
    let button = UIButton(type: .infoLight)
    let hintView = UIView()

    // MARK: Public API

    init(configuration: Squawk.Configuration) {
        super.init(frame: .zero)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)

        backgroundView.backgroundColor = configuration.backgroundColor
        backgroundView.layer.cornerRadius = configuration.cornerRadius
        backgroundView.layer.borderColor = configuration.borderColor.cgColor
        backgroundView.layer.borderWidth = 1.0 / UIScreen.main.nativeScale
        backgroundView.clipsToBounds = true

        let contentView = backgroundView.contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0
        label.textColor = .white
        label.text = configuration.text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        contentView.addSubview(label)

        if configuration.buttonVisible {
            button.tintColor = .white
            button.addTarget(self, action: #selector(SquawkView.onButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)

            addConstraint(NSLayoutConstraint(
                item: button,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: label,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            ))
        }

        hintView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        hintView.layer.cornerRadius = configuration.hintSize.height / 2
        hintView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hintView)

        // center the hint beneath the label
        addConstraint(NSLayoutConstraint(
            item: hintView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: configuration.hintSize.width
        ))
        addConstraint(NSLayoutConstraint(
            item: hintView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        ))

        let subviews: [String: UIView] = [
            "button": button,
            "label": label,
            "hintView": hintView,
            "contentView": contentView
        ]

        if configuration.buttonVisible {
            let labelWidth = configuration.maxWidth - configuration.buttonLeftMargin - configuration.insets.left - configuration.insets.right
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-\(configuration.insets.left)-[label(<=\(labelWidth))]-\(configuration.buttonLeftMargin)-[button]-\(configuration.insets.right)-|",
                metrics: nil,
                views: subviews
            ))
        } else {
            let labelWidth = configuration.maxWidth - configuration.insets.left - configuration.insets.right
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-\(configuration.insets.left)-[label(<=\(labelWidth))]-\(configuration.insets.right)-|",
                metrics: nil,
                views: subviews
            ))
        }

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-\(configuration.insets.top)-[label]-\(configuration.hintTopMargin)-[hintView(\(configuration.hintSize.height))]-\(configuration.insets.bottom)-|",
            metrics: nil,
            views: subviews
        ))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[contentView]|",
            metrics: nil,
            views: subviews
        ))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[contentView]|",
            metrics: nil,
            views: subviews
        ))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = bounds
    }

    func contentSize() -> CGSize {
        backgroundView.updateConstraintsIfNeeded()
        backgroundView.layoutIfNeeded()
        return backgroundView.contentView.bounds.size
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private API

    @objc func onButton() {
        delegate?.didTapInfo(for: self)
    }

}
