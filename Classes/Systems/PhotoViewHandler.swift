//
//  PhotoViewHandler.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import NYTPhotoViewer
import SDWebImage
import Squawk

final class PhotoViewHandler: NSObject,
    IssueCommentImageCellDelegate,
NYTPhotosViewControllerDelegate,
IssueCommentHtmlCellImageDelegate {

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
        viewController?.present(photosViewController, animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: NYTPhotosViewControllerDelegate

    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        return referenceImageView
    }

    // MARK: IssueCommentHtmlCellImageDelegate

    func webViewDidTapImage(cell: IssueCommentHtmlCell, url: URL) {
        // cannot download svgs yet
        guard url.pathExtension != "svg" else { return }

        SDWebImageDownloader.shared().downloadImage(
            with: url,
            options: [.highPriority],
            progress: nil
        ) { [weak self] (image, data, _, _) in
            if let image = image {
                let photo = IssueCommentPhoto(image: image, data: nil)
                let photosViewController = NYTPhotosViewController(photos: [photo])
                self?.viewController?.present(photosViewController, animated: trueUnlessReduceMotionEnabled)
            } else {
                Squawk.showGenericError()
            }
        }
    }

}
