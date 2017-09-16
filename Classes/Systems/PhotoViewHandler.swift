//
//  PhotoViewHandler.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import NYTPhotoViewer
import IGListKit
import SDWebImage

final class PhotoViewHandler: NSObject,
    IssueCommentImageCellDelegate,
NYTPhotosViewControllerDelegate {

    private weak var viewController: UIViewController? = nil
    private weak var referenceImageView: UIImageView? = nil
    private var imageModels: [IssueCommentImageModel]?
    
    init(viewController: UIViewController?, models: [ListDiffable]) {
        self.viewController = viewController
        self.imageModels = models.flatMap({ $0 as? IssueCommentImageModel })
    }

    // MARK: IssueCommentImageCellDelegate

    func didTapImage(cell: IssueCommentImageCell, image: UIImage, url: URL) {
        referenceImageView = cell.imageView
        
        var photos = [IssueCommentPhoto(image: image)]
        
        imageModels?.forEach({
            guard $0.url.absoluteString != url.absoluteString else { return }
            guard let image = SDImageCache.shared().imageFromCache(forKey: $0.url.absoluteString) else { return }
            photos.append(IssueCommentPhoto(image: image))
        })
        
        let photosViewController = NYTPhotosViewController(photos: photos)
        photosViewController.delegate = self
        viewController?.present(photosViewController, animated: true)
    }

    // MARK: NYTPhotosViewControllerDelegate

    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        return referenceImageView
    }

}

