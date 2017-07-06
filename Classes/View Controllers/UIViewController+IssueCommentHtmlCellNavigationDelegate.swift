//
//  UIViewController+IssueCommentHtmlCellNavigationDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController: IssueCommentHtmlCellNavigationDelegate {

    func webViewWantsNavigate(cell: IssueCommentHtmlCell, url: URL) {
        presentSafari(url: url)
    }

}
