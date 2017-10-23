//
//  IssueCommentPhoto.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import NYTPhotoViewer

final class IssueCommentPhoto: NSObject, NYTPhoto {

    let image: UIImage?
    let imageData: Data?

    init(image: UIImage, data: Data?) {
        self.image = image
        self.imageData = data
    }

    // unused
    let placeholderImage: UIImage? = nil
    let attributedCaptionTitle: NSAttributedString? = nil
    let attributedCaptionCredit: NSAttributedString? = nil
    let attributedCaptionSummary: NSAttributedString? = nil

}
