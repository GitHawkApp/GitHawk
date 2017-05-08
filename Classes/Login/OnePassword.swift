//
//  OnePassword.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import OnePasswordExtension

enum OnePasswordResult {
    case success(username: String, password: String)
    case cancelled
    case failure(error: Error?)
}

func onePasswordAvailable() -> Bool {
    return OnePasswordExtension.shared().isAppExtensionAvailable()
}

func onePasswordShow(
    viewController: UIViewController,
    completion: @escaping (OnePasswordResult) -> ()
    ) {
    OnePasswordExtension.shared()
        .findLogin(
        forURLString: "https://github.com",
        for: viewController,
        sender: nil
        ) { (dict, err) in
        if let username = dict?[AppExtensionUsernameKey] as? String,
            let password = dict?[AppExtensionPasswordKey] as? String {
            completion(.success(username: username, password: password))
        } else if let error = err as NSError?,
            (error as NSError).code == Int(AppExtensionErrorCodeCancelledByUser) {
            completion(.cancelled)
        } else {
            completion(.failure(error: err))
        }
    }
}
