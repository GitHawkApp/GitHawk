//
//  UIViewController+PresentLabels.swift
//  Freetime
//
//  Created by B_Litwin on 10/17/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentLabels(label: LabelDetails) {
        let repositoryIssuesViewController =
            RepositoryIssuesViewController(
                client: label.client,
                owner: label.owner,
                repo: label.repo,
                type: .issues
        )
        
        navigationController?.pushViewController(
            repositoryIssuesViewController,
            animated: true
        )
    }
}
