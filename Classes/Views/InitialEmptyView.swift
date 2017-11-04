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

    init(imageName: String, title: String, description: String) {
        super.init(frame: .zero)

        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Styles.Colors.Gray.border.color
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-(imageView.image?.size.height ?? 0)/2)
        }

        titleLabel.font = Styles.Fonts.title
        titleLabel.text = title
        titleLabel.textColor = Styles.Colors.Gray.light.color
        titleLabel.backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(2*Styles.Sizes.rowSpacing)
        }

        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = Styles.Fonts.body
        descriptionLabel.text = description
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

    // MARK: Private API

    @objc
    func onTap() {
        delegate?.didTap(emptyView: self)
    }

}
