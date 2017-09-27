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

protocol IssueCommentImageHeightCellDelegate: class {
    func imageDidFinishLoad(cell: IssueCommentImageCell, url: URL, size: CGSize)
}

final class IssueCommentImageCell: UICollectionViewCell,
ListBindable,
CollapsibleCell,
UIGestureRecognizerDelegate {

    weak var delegate: IssueCommentImageCellDelegate? = nil
    weak var heightDelegate: IssueCommentImageHeightCellDelegate? = nil

    let imageView = UIImageView()

    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private let overlay = CreateCollapsibleOverlay()
    private var tapGesture: UITapGestureRecognizer!

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true
        contentView.backgroundColor = .white

        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        spinner.hidesWhenStopped = true
        contentView.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(IssueCommentImageCell.onTap(recognizer:)))
        tapGesture.delegate = self
        contentView.addGestureRecognizer(tapGesture)
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
        // action will only trigger if shouldBegin returns true
        guard let image = imageView.image else { return }
        delegate?.didTapImage(cell: self, image: image)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentImageModel else { return }
        imageView.backgroundColor = Styles.Colors.Gray.lighter.color
        spinner.startAnimating()

        let imageURL = viewModel.url
        imageView.sd_setImage(with: imageURL) { [weak self] (image, error, type, url) in
            guard let strongSelf = self else { return }
            strongSelf.imageView.backgroundColor = .clear
            strongSelf.spinner.stopAnimating()

            if let size = image?.size {
                strongSelf.heightDelegate?.imageDidFinishLoad(cell: strongSelf, url: imageURL, size: size)
            }
        }
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

    // MARK: UIGestureRecognizerDelegate

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer === tapGesture
            else { return super.gestureRecognizerShouldBegin(gestureRecognizer) }

        // only start the image tap gesture when an image exists
        // and the tap is within the actual image's bounds
        guard let image = imageView.image,
            overlay.isHidden
            else { return false }

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

        let location = gestureRecognizer.location(in: imageView)
        return imageBounds.contains(location)
    }
    
}
