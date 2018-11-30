//
//  UIViewController+CommonActionItems.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func action(owner: String, icon: UIImage = UIImage()) -> UIAlertAction? {
        weak var weakSelf = self
        return AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf })
            .view(owner: owner, icon: icon)
    }

    func action(
        owner: String,
        repo: String,
        icon: UIImage,
        client: GithubClient
        ) -> UIAlertAction? {
        let repo = RepositoryDetails(
            owner: owner,
            name: repo
        )
        weak var weakSelf = self
        return AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf })
            .view(client: client, repo: repo, icon: icon)
    }

}
