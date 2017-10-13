//
//  UIViewController+LoadingIndicator.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func showLoadingIndicator(_ show: Bool) {
        if show {
            let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.startAnimating()
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

}
