//
//  InitialEmptyViewCell.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class InitialEmptyViewCell: UICollectionViewCell {

    private let emptyView = InitialEmptyView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(emptyView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        emptyView.frame = contentView.bounds
    }

    func configure(with model: InitialEmptyViewModel) {
        emptyView.configure(
            imageName: model.imageName,
            title: model.title,
            description: model.description
        )
    }

}
