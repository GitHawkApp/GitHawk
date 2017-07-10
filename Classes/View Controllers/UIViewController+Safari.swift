//
//  UIViewController+Safari.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {

    func presentSafari(url: URL) {
        present(SFSafariViewController(url: url), animated: true)
    }

    func presentProfile(login: String) {
        present(CreateProfileViewController(login: login), animated: true)
    }

    func presentCommit(owner: String, repo: String, hash: String) {
        guard let url = URL(string: "https://github.com/\(owner)/\(repo)/commit/\(hash)") else { return }
        presentSafari(url: url)
    }

}
