//
//  UIPopoverPresentationController+SourceView.swift
//  Freetime
//
//  Created by Joe Rocca on 11/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UIPopoverPresentationController {
    func setSourceView(_ view: UIView) {
        sourceView = view
        sourceRect = view.bounds
    }
}
