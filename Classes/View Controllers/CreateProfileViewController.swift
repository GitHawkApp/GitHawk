//
//  CreateProfileViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

func CreateProfileViewController(login: String) -> UIViewController {
    // TODO: REVISE (Also shouldn't assume URL, https://github.com/rnystrom/GitHawk/issues/159)
    let url = URL(string: "https://github.com/\(login)")!
	return try! SFSafariViewController.configured(with: url)
}
