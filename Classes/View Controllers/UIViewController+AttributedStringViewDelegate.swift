//
//  UIViewController+AttributedStringViewDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController: AttributedStringViewDelegate {

    func didTapURL(view: AttributedStringView, url: URL) {
        presentSafari(url: url)
    }

    func didTapUsername(view: AttributedStringView, username: String) {
        presentProfile(login: username)
    }

    func didTapEmail(view: AttributedStringView, email: String) {
        guard let url = URL(string: "mailTo:\(email)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func didTapLabel(view: AttributedStringView, label: LabelDetails) {
        presentLabels(owner: label.owner, repo: label.repo, label: label.label)
    }

    func didTapCommit(view: AttributedStringView, commit: CommitDetails) {
        presentCommit(owner: commit.owner, repo: commit.repo, hash: commit.hash)
    }

}
