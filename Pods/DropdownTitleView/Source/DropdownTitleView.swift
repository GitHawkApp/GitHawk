//
//  NavigationTitleDropdownView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

open class DropdownTitleView: UIControl {

    internal let titleLabel = UILabel()
    internal let subtitleLabel = UILabel()
    internal let chevron = UIImageView(image: UIImage(
        named: "chevron-down-small",
        in: Bundle(for: DropdownTitleView.self),
        compatibleWith: nil
        )?.withRenderingMode(.alwaysTemplate)
    )
    internal let horizontalStackView = UIStackView()
    internal let verticalStackView = UIStackView()

    public init() {
        super.init(frame: .zero)
        isAccessibilityElement = true
        accessibilityTraits |= UIAccessibilityTraitButton

        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.setContentCompressionResistancePriority(.required, for: .horizontal)
        chevron.setContentCompressionResistancePriority(.required, for: .vertical)
        chevron.setContentHuggingPriority(.required, for: .horizontal)
        chevron.setContentHuggingPriority(.required, for: .vertical)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingHead
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.75
        titleLabel.textColor = UIColor.darkText
        titleLabel.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        titleLabel.isAccessibilityElement = false

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textAlignment = .center
        subtitleLabel.lineBreakMode = .byTruncatingHead
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.minimumScaleFactor = 0.75
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        subtitleLabel.isAccessibilityElement = false

        verticalStackView.isUserInteractionEnabled = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.alignment = .center
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalCentering
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)

        horizontalStackView.isUserInteractionEnabled = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalCentering
        horizontalStackView.spacing = 4
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(chevron)

        addSubview(horizontalStackView)

        horizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        horizontalStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addConstraint(NSLayoutConstraint(item: horizontalStackView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: horizontalStackView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 1, constant: 0))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc dynamic open var chevronTintColor: UIColor? {
        get {
            return chevron.tintColor
        }
        set {
            chevron.tintColor = newValue
        }
    }

    @objc dynamic open var titleFont: UIFont {
        get {
            return titleLabel.font
        }
        set {
            titleLabel.font = newValue
            invalidateIntrinsicContentSize()
        }
    }

    @objc dynamic open var titleColor: UIColor {
        get {
            return titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
        }
    }

    @objc dynamic open var subtitleFont: UIFont {
        get {
            return subtitleLabel.font
        }
        set {
            subtitleLabel.font = newValue
            invalidateIntrinsicContentSize()
        }
    }

    @objc dynamic open var subtitleColor: UIColor {
        get {
            return subtitleLabel.textColor
        }
        set {
            subtitleLabel.textColor = newValue
        }
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        fadeControls(alpha: 0.5)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        fadeControls(alpha: 1)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        fadeControls(alpha: 1)
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return horizontalStackView.systemLayoutSizeFitting(size)
    }

    open override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return horizontalStackView.systemLayoutSizeFitting(targetSize)
    }

    override open var intrinsicContentSize: CGSize {
        return UILayoutFittingCompressedSize
    }

    // MARK: Public API

    open func configure(
        title: String,
        subtitle: String? = nil,
        chevronEnabled: Bool = true,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil
        ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        self.accessibilityLabel = accessibilityLabel ?? title
        self.accessibilityHint = accessibilityHint

        chevron.isHidden = !chevronEnabled
        subtitleLabel.isHidden = !(subtitle?.isEmpty == false)

        invalidateIntrinsicContentSize()
    }

    // MARK: Private API

    internal var chevronEnabled: Bool {
        return chevron.superview != nil
    }

    internal func fadeControls(alpha: CGFloat) {
        guard chevronEnabled else { return }
        [titleLabel, subtitleLabel, chevron].forEach { $0.alpha = alpha }
    }

}
