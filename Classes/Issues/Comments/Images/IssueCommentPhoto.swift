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

    init(image: UIImage) {
        self.image = image
    }

    // unused
    let imageData: Data? = nil
    let placeholderImage: UIImage? = nil
    let attributedCaptionTitle: NSAttributedString? = nil
    let attributedCaptionCredit: NSAttributedString? = nil
    let attributedCaptionSummary: NSAttributedString? = nil

}
