//
//  EmptyView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol EmptyViewDelegate: class {
    func didTapRetry()
}

final class EmptyView: UIView {

    let label = UILabel()
    let button = UIButton(type: .system)
    var delegate: EmptyViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = Styles.Text.body.preferredFont
        label.textColor = Styles.Colors.Gray.medium.color
        label.numberOfLines = 0
        addSubview(label)

        button.isHidden = true
        button.titleLabel?.font = Styles.Text.button.preferredFont
        button.setTitle(Constants.Strings.tryAgain, for: .normal)
        button.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)
        button.addTarget(self, action: #selector(tapRetry), for: .touchUpInside)
        addSubview(button)

        label.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.lessThanOrEqualToSuperview().offset(-Styles.Sizes.gutter)
        }

        button.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(label).offset(Styles.Sizes.gutter)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tapRetry(sender: UIButton) {
        delegate?.didTapRetry()
    }
}
