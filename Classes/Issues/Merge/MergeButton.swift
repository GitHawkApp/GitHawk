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

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(mergeLabel)
        addSubview(optionIconView)
        addSubview(optionBorder)
        addSubview(activityView)

        layer.cornerRadius = Styles.Sizes.avatarCornerRadius

        let image = UIImage(named: "chevron-down")?.withRenderingMode(.alwaysTemplate)
        let optionButtonWidth = (image?.size.width ?? 0) + 2*Styles.Sizes.gutter
        optionIconView.contentMode = .center
        optionIconView.image = image
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

    // MARK: Public

    func configure(title: String, enabled: Bool, loading: Bool) {
        isUserInteractionEnabled = enabled && !loading

        backgroundColor = (enabled
            ? Styles.Colors.Green.medium.color
            : Styles.Colors.Gray.light.color)
            .withAlphaComponent(loading ? 0.2 : 1)
        alpha = enabled ? 1 : 0.3

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
