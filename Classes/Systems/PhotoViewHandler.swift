//
//  PhotoViewHandler.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import NYTPhotoViewer

final class PhotoViewHandler: NSObject,
    IssueCommentImageCellDelegate,
NYTPhotosViewControllerDelegate {

    private weak var viewController: UIViewController?
    private weak var referenceImageView: UIImageView?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    // MARK: IssueCommentImageCellDelegate

    func didTapImage(cell: IssueCommentImageCell, image: UIImage, animatedImageData: Data?) {
        referenceImageView = cell.imageView
        let photo = IssueCommentPhoto(image: image, data: animatedImageData)
        let photosViewController = NYTPhotosViewController(photos: [photo])
        photosViewController.delegate = self
        viewController?.present(photosViewController, animated: true)
    }

    // MARK: NYTPhotosViewControllerDelegate

    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        return referenceImageView
    }

}
