//
//  UIViewController+HistoryAction.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {
    func viewHistoryAction(
        owner: String,
        repo: String,
        branch: String,
        client: GithubClient,
        path: FilePath? = nil
        ) -> UIAlertAction {
        return UIAlertAction(
            title: NSLocalizedString("View History", comment: ""),
            style: .default
        ) { [weak self] _ in
            self?.navigationController?.pushViewController(
                PathHistoryViewController(
                    viewModel: PathHistoryViewModel(
                        owner: owner,
                        repo: repo,
                        client: client,
                        branch: branch,
                        path: path
                    )
                ),
                animated: trueUnlessReduceMotionEnabled
            )
        }
    }
}
