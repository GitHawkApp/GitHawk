//
//  SearchEmptyView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchEmptyViewDelegate: class {
    func didTap(emptyView: SearchEmptyView)
}

final class SearchEmptyView: UIView {

    weak var delegate: SearchEmptyViewDelegate?

    private let imageView = UIImageView(image: UIImage(named: "search-large")?.withRenderingMode(.alwaysTemplate))
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.tintColor = Styles.Colors.Gray.border.color
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-(imageView.image?.size.height ?? 0)/2)
        }

        titleLabel.font = Styles.Fonts.title
        titleLabel.text = NSLocalizedString("Search GitHub", comment: "")
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
        descriptionLabel.text = NSLocalizedString("Find your favorite repositories.\nRecent searches are saved.", comment: "")
        descriptionLabel.textColor = Styles.Colors.Gray.light.color
        descriptionLabel.backgroundColor = .clear
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
        }

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SearchEmptyView.onTap)))
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
