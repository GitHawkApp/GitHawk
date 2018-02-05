//
//  NavigationTitleDropdownView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class NavigationTitleDropdownView: UIControl {

    private static let spacing: CGFloat = 4

    private let label = UILabel()
    private let chevron = UIImageView(image: UIImage(named: "chevron-down-small")?.withRenderingMode(.alwaysTemplate))

    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true
        accessibilityTraits |= UIAccessibilityTraitButton

        let chevronSize = chevron.image?.size ?? .zero

        chevron.tintColor = Styles.Colors.Gray.medium.color
        chevron.setContentCompressionResistancePriority(.required, for: .horizontal)
        chevron.setContentCompressionResistancePriority(.required, for: .vertical)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chevron)

        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        addSubview(label)

        chevron.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(NavigationTitleDropdownView.spacing)
            make.right.lessThanOrEqualTo(self)
            make.centerY.equalTo(self)
            make.size.equalTo(chevronSize)
        }

        label.snp.makeConstraints { make in
//            make.center.equalTo(self)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-2)
            make.top.bottom.left.lessThanOrEqualTo(self).priority(.high)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let greatest = CGFloat.greatestFiniteMagnitude
        let labelSize = label.sizeThatFits(CGSize(width: greatest, height: greatest))
        let chevronSize = chevron.image?.size ?? .zero
        return CGSize(
            width: labelSize.width + NavigationTitleDropdownView.spacing + chevronSize.width,
            height: max(chevronSize.height, labelSize.height)
        )
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        fadeControls(alpha: 0.5)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        fadeControls(alpha: 1)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        fadeControls(alpha: 1)
    }

    // MARK: Public API

    func configure(title: String?, subtitle: String?, accessibilityLabel: String? = nil) {
        guard let title = title else { return }

        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.bodyBold.preferredFont,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]

        let attributedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        if let subtitle = subtitle {
            attributedTitle.append(NSAttributedString(string: "\n"))
            attributedTitle.append(NSAttributedString(string: subtitle, attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.light.color
                ]))
        }

        label.attributedText = attributedTitle

        self.accessibilityLabel = accessibilityLabel ?? title

        invalidateIntrinsicContentSize()

        translatesAutoresizingMaskIntoConstraints = false
        layoutIfNeeded()
        sizeToFit()
        translatesAutoresizingMaskIntoConstraints = true
    }

    // MARK: Private API

    func fadeControls(alpha: CGFloat) {
        [label, chevron].forEach { $0.alpha = alpha }
    }

}

