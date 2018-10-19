//
//  UIViewController+PresentLabels.swift
//  Freetime
//
//  Created by B_Litwin on 10/19/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubAPI

extension UIViewController {
    func presentLabels(client: GithubClient, owner: String, repo: String, label: String) {
        let repositoryIssuesViewController =
            RepositoryIssuesViewController(
                client: client,
                owner: owner,
                repo: repo,
                type: .issues,
                label: label
        )
        
        navigationController?.pushViewController(
            repositoryIssuesViewController,
            animated: true
        )
    }
}
