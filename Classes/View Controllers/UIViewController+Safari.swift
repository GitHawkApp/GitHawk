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
        let http = "http"
        let schemedURL: URL
        // handles http and https
        if url.scheme?.hasPrefix(http) == true {
            schemedURL = url
        } else {
            guard let u = URL(string: http + "://" + url.absoluteString) else { return }
            schemedURL = u
        }
        present(SFSafariViewController(url: schemedURL), animated: true)
    }

    func presentProfile(login: String) {
        present(CreateProfileViewController(login: login), animated: true)
    }

    func presentCommit(owner: String, repo: String, hash: String) {
        guard let url = URL(string: "https://github.com/\(owner)/\(repo)/commit/\(hash)") else { return }
        presentSafari(url: url)
    }

    func presentLabels(owner: String, repo: String, label: String) {
        guard let url = URL(string: "https://github.com/\(owner)/\(repo)/labels/\(label)") else { return }
        presentSafari(url: url)
    }

    func presentMilestone(owner: String, repo: String, milestone: Int) {
        guard let url = URL(string: "https://github.com/\(owner)/\(repo)/milestone/\(milestone)") else { return }
        presentSafari(url: url)
    }

}
