//
//  IssueCommentImageCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import IGListKit

final class IssueCommentImageCell: UICollectionViewCell {

    let imageView = UIImageView()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        spinner.hidesWhenStopped = true
        contentView.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        LayoutCollapsible(layer: overlay, view: contentView)
    }
    
}

extension IssueCommentImageCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentImageModel else { return }
        imageView.backgroundColor = Styles.Colors.Gray.lighter
        spinner.startAnimating()
        imageView.sd_setImage(with: viewModel.url) { [unowned self] (image, error, type, url) in
            self.imageView.backgroundColor = .clear
            self.spinner.stopAnimating()
        }
    }

}

extension IssueCommentImageCell: CollapsibleCell {

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

}
