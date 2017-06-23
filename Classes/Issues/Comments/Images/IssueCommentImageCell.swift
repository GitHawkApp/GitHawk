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

protocol IssueCommentImageCellDelegate: class {
    func didTapImage(cell: IssueCommentImageCell, image: UIImage)
}

final class IssueCommentImageCell: UICollectionViewCell, ListBindable, CollapsibleCell {

    static let preferredHeight: CGFloat = 200

    weak var delegate: IssueCommentImageCellDelegate? = nil
    let imageView = UIImageView()

    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true
        contentView.backgroundColor = .white

        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(IssueCommentImageCell.preferredHeight)
        }

        spinner.hidesWhenStopped = true
        contentView.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(IssueCommentImageCell.onTap(recognizer:)))
        contentView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        LayoutCollapsible(layer: overlay, view: contentView)
    }

    // MARK: Private API

    func onTap(recognizer: UITapGestureRecognizer) {
        guard let image = imageView.image,
        overlay.isHidden
            else { return }
        
        let imageSize = image.size
        let imageViewBounds = imageView.bounds

        // https://stackoverflow.com/a/2351101/940936
        let ratioX = imageViewBounds.width/imageSize.width
        let ratioY = imageViewBounds.height/imageSize.height
        let imageBounds: CGRect
        if ratioX < ratioY {
            let height = ratioX * imageSize.height
            imageBounds = CGRect(
                x: 0,
                y: (imageViewBounds.height - height) / 2,
                width: imageViewBounds.width,
                height: height
            )
        } else {
            let width = ratioY * imageSize.width
            imageBounds = CGRect(
                x: (imageViewBounds.width - width) / 2,
                y: 0,
                width: width,
                height: imageViewBounds.height
            )
        }

        let location = recognizer.location(in: imageView)
        guard imageBounds.contains(location) else { return }

        delegate?.didTapImage(cell: self, image: image)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentImageModel else { return }
        imageView.backgroundColor = Styles.Colors.Gray.lighter.color
        spinner.startAnimating()
        imageView.sd_setImage(with: viewModel.url) { [unowned self] (image, error, type, url) in
            self.imageView.backgroundColor = .clear
            self.spinner.stopAnimating()
        }
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }
    
}
