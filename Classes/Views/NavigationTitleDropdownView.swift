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

    init(chevronVisible: Bool = true) {
        super.init(frame: .zero)
        isAccessibilityElement = true
        accessibilityTraits |= UIAccessibilityTraitButton

        let chevronSize = chevron.image?.size ?? .zero

        if chevronVisible {
            chevron.tintColor = Styles.Colors.Gray.medium.color
            chevron.setContentCompressionResistancePriority(.required, for: .horizontal)
            chevron.setContentCompressionResistancePriority(.required, for: .vertical)
            chevron.translatesAutoresizingMaskIntoConstraints = false
            addSubview(chevron)
        }

        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingHead
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        addSubview(label)

        if chevronVisible {
            chevron.snp.makeConstraints { make in
                make.left.equalTo(label.snp.right).offset(NavigationTitleDropdownView.spacing)
                make.right.lessThanOrEqualTo(self)
                make.centerY.equalTo(self)
                make.size.equalTo(chevronSize)
            }
        }

        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(chevronVisible ? -2 : 0)
            make.top.bottom.left.right.lessThanOrEqualTo(self).priority(.high)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let greatest = CGFloat.greatestFiniteMagnitude
        let labelSize = label.sizeThatFits(CGSize(width: greatest, height: greatest))
        let chevronSpacing = dropdownEnabled
            ? (chevron.image?.size ?? .zero).width + NavigationTitleDropdownView.spacing
            : 0
        return CGSize(
            width: labelSize.width + chevronSpacing,
            height: labelSize.height
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

    func configure(
        title: String?,
        subtitle: String?,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil
        ) {
        guard let title = title else { return }

        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.bodyBold.preferredFont,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]

        let attributedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        if let subtitle = subtitle, !subtitle.isEmpty {
            attributedTitle.append(NSAttributedString(string: "\n"))
            attributedTitle.append(NSAttributedString(string: subtitle, attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.light.color
                ]))
        }

        label.attributedText = attributedTitle

        self.accessibilityLabel = accessibilityLabel ?? title
        self.accessibilityHint = accessibilityHint
    }

    // MARK: Private API

    private var dropdownEnabled: Bool {
        return chevron.superview != nil
    }

    private func fadeControls(alpha: CGFloat) {
        guard dropdownEnabled else { return }
        [label, chevron].forEach { $0.alpha = alpha }
    }

}
