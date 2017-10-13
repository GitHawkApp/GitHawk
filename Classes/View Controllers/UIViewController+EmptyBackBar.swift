//
//  UIViewController+EmptyBackBar.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 10/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func makeBackBarItemEmpty() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }

}
