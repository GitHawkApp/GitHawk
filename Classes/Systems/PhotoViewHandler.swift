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
    private var singlePhotoDataSource: NYTPhotoViewerSinglePhotoDataSource?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    // MARK: IssueCommentImageCellDelegate

    func didTapImage(cell: IssueCommentImageCell, image: UIImage, animatedImageData: Data?) {
        referenceImageView = cell.imageView
        let photo = IssueCommentPhoto(image: image, data: animatedImageData)
        let dataSource = NYTPhotoViewerSinglePhotoDataSource(photo: photo)
        singlePhotoDataSource = dataSource
        viewController?.route_present(to: NYTPhotosViewController(
            dataSource: dataSource,
            initialPhoto: photo,
            delegate: self
        ))
    }

    // MARK: NYTPhotosViewControllerDelegate

    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        return referenceImageView
    }

    func photosViewControllerDidDismiss(_ photosViewController: NYTPhotosViewController) {
        referenceImageView = nil
    }

    // MARK: IssueCommentHtmlCellImageDelegate

    func webViewDidTapImage(cell: IssueCommentHtmlCell, url: URL) {
        // cannot download svgs yet
        guard url.pathExtension != "svg" else { return }

        let isGif = url.pathExtension.lowercased() == "gif"

        let photo = IssueCommentPhoto()
        let dataSource = NYTPhotoViewerSinglePhotoDataSource(photo: photo)
        singlePhotoDataSource = dataSource
        let controller = NYTPhotosViewController(dataSource: dataSource, initialPhoto: photo, delegate: self)
        viewController?.route_present(to: controller)

        SDWebImageDownloader.shared().downloadImage(
            with: url,
            options: [.highPriority],
            progress: nil
        ) { (image, data, _, _) in
            if image != nil || data != nil {
                if isGif {
                    photo.imageData = data
                } else {
                    photo.image = image
                }
                controller.update(photo)
            } else {
                Squawk.showGenericError()
            }
        }
    }

}
