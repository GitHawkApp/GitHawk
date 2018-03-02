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
    let url = GithubClient.url(path: login)!
	return try! SFSafariViewController.configured(with: url)
}
