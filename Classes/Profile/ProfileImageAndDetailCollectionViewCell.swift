//
//  ProfileImageAndDetailCollectionViewCell.swift
//  Freetime
//
//  Created by B_Litwin on 8/16/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class ProfileImageAndDetailCollectionViewCell: UICollectionViewCell, ListBindable {
    private let imageView = UIImageView()
    private let stackview = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //configure imageView
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(contentView.snp.top).offset(Styles.Sizes.gutter)
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        
        //configure stackview
        contentView.addSubview(stackview)
        stackview.axis = .vertical
        stackview.spacing = Styles.Sizes.rowSpacing
        stackview.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(Styles.Sizes.gutter)
            make.trailing.equalTo(contentView.snp.trailing)
            make.top.equalTo(contentView.snp.top).offset(Styles.Sizes.gutter)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ProfileImageAndDetailViewModel else { return }
        if let url = URL(string: viewModel.avatarURL) {
            imageView.sd_setImage(with: url)
        }
        
        stackview.addArrangedSubview(
            NameAndLoginLabel(login: viewModel.login,
                              name: viewModel.name
            )
        )
        
        if let location = viewModel.location {
            let locationLabel = LocationLabel(location: location)
            stackview.addArrangedSubview(locationLabel)
        }
    }
}

