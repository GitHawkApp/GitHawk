//
//  UIViewController+StyledTextViewCellDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/18/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController: MarkdownStyledTextViewDelegate {

    func didTap(cell: MarkdownStyledTextView, attribute: DetectedMarkdownAttribute) {
        handle(attribute: attribute)
    }

}
