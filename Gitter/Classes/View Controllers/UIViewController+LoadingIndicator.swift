//
//  UIViewController+LoadingIndicator.swift
//  Gitter
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func showLoadingIndicator(show: Bool) {
        if show {
            navigationItem.rightBarButtonItem = nil
        } else {
            let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.startAnimating()
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        }
    }

}
