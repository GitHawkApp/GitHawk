//
//  InitialEmptyView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol InitialEmptyViewDelegate: class {
    func didTap(emptyView: InitialEmptyView)
}

final class InitialEmptyView: UIView {

    weak var delegate: InitialEmptyViewDelegate?

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        accessibilityIdentifier = "initial-empty-view"

        imageView.tintColor = Styles.Colors.Gray.border.color
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        titleLabel.font = Styles.Text.title.preferredFont
        titleLabel.textColor = Styles.Colors.Gray.light.color
        titleLabel.backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(2*Styles.Sizes.rowSpacing)
        }

        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = Styles.Text.body.preferredFont
        descriptionLabel.textColor = Styles.Colors.Gray.light.color
        descriptionLabel.backgroundColor = .clear
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
        }

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(InitialEmptyView.onTap)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(imageName: String, title: String, description: String) {
        if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
            imageView.image = image
            imageView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-image.size.height / 2)
            }
        }
        titleLabel.text = title
        descriptionLabel.text = description
    }

    // MARK: Private API

    @objc func onTap() {
        delegate?.didTap(emptyView: self)
    }

}
