//
//  IssueCommentImageCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueCommentImageCell: UICollectionViewCell {

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.backgroundColor = Styles.Colors.Gray.lighter
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
