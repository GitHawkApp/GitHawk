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

    // mutable to create the model, mutate, and tell the NYTP... to update
    // https://github.com/NYTimes/NYTPhotoViewer/issues/203#issuecomment-264474752
    var image: UIImage?
    var imageData: Data?

    init(image: UIImage? = nil, data: Data? = nil) {
        self.image = image
        self.imageData = data
    }

    // unused
    let placeholderImage: UIImage? = nil
    let attributedCaptionTitle: NSAttributedString? = nil
    let attributedCaptionCredit: NSAttributedString? = nil
    let attributedCaptionSummary: NSAttributedString? = nil

}
