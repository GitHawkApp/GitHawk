//
//  MergeButton.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol MergeButtonDelegate: class {
    func didSelect(button: MergeButton)
    func didSelectOptions(button: MergeButton)
}

final class MergeButton: UIView {

    weak var delegate: MergeButtonDelegate?

    // public to use as source view for popover
    let optionIconView = UIImageView()

    private let mergeLabel = UILabel()
    private let optionBorder = UIView()
    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(mergeLabel)
        addSubview(optionIconView)
        addSubview(optionBorder)
        addSubview(activityView)

        layer.cornerRadius = Styles.Sizes.avatarCornerRadius

        let image = UIImage(named: "chevron-down")?.withRenderingMode(.alwaysTemplate)
        let optionButtonWidth = (image?.size.width ?? 0) + (2 * Styles.Sizes.gutter)
        optionIconView.contentMode = .center
        optionIconView.image = image
        optionIconView.isAccessibilityElement = true
        optionIconView.accessibilityTraits = UIAccessibilityTraitButton
        optionIconView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(optionButtonWidth)
        }

        mergeLabel.font = Styles.Text.bodyBold.preferredFont
        mergeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-optionButtonWidth/2)
        }

        optionBorder.alpha = 0.7
        optionBorder.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Styles.Sizes.rowSpacing/2)
            make.bottom.equalToSuperview().offset(-Styles.Sizes.rowSpacing/2)
            make.width.equalTo(1/UIScreen.main.scale)
            make.right.equalTo(optionIconView.snp.left)
        }

        activityView.hidesWhenStopped = true
        activityView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(mergeLabel.snp.left).offset(-Styles.Sizes.columnSpacing)
        }

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:))))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    // MARK: Public

    func configure(title: String, enabled: Bool, loading: Bool) {
        isUserInteractionEnabled = enabled && !loading

        backgroundColor = (enabled
            ? (loading ? Styles.Colors.Green.medium.color : .clear)
            : Styles.Colors.Gray.light.color)
            .withAlphaComponent(loading ? 0.2 : 1)
        alpha = enabled ? 1 : 0.3

        if enabled && !loading {
            guard gradientLayer.superlayer == nil else { return }
            gradientLayer.cornerRadius = layer.cornerRadius
            gradientLayer.colors = [
                UIColor.fromHex("34d058").cgColor,
                Styles.Colors.Green.medium.color.cgColor
            ]
            layer.addSublayer(gradientLayer)

            [mergeLabel, optionIconView, optionBorder, activityView].forEach {
                bringSubview(toFront: $0)
            }
        } else {
            gradientLayer.removeFromSuperlayer()
        }

        let titleColor = enabled ? .white : Styles.Colors.Gray.dark.color
        mergeLabel.textColor = titleColor
        optionIconView.tintColor = titleColor
        optionBorder.backgroundColor = titleColor

        mergeLabel.text = title

        if loading {
            activityView.startAnimating()
        } else {
            activityView.stopAnimating()
        }

        let mergeButtonElement = mergeElement(withAccessibilityLabel: title)
        accessibilityElements = [mergeButtonElement, optionIconView]
        optionIconView.accessibilityLabel = NSLocalizedString("More merging options", comment: "More options button for merging")
    }

    // MARK: Overrides

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // don't highlight when touching inside the chevron button
        if let touch = touches.first, optionIconView.frame.contains(touch.location(in: self)) {
            return
        }
        highlight(true)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        highlight(false)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        highlight(false)
    }

    // MARK: Private API

    private func mergeElement(withAccessibilityLabel accessibilityLabel: String) -> UIAccessibilityElement {
        let element = UIAccessibilityElement(accessibilityContainer: self)
        element.accessibilityLabel = accessibilityLabel
        element.accessibilityFrameInContainerSpace = CGRect(
            origin: bounds.origin,
            size: CGSize(
                width: bounds.size.width - optionIconView.bounds.size.width,
                height: bounds.size.height
            )
        )
        element.accessibilityTraits |= UIAccessibilityTraitButton
        return element
    }

    func highlight(_ highlight: Bool) {
        guard isUserInteractionEnabled else { return }
        alpha = highlight ? 0.5 : 1
    }

    @objc func onTap(recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .ended else { return }

        if optionIconView.frame.contains(recognizer.location(in: self)) {
            delegate?.didSelectOptions(button: self)
        } else {
            delegate?.didSelect(button: self)
        }
    }

}
