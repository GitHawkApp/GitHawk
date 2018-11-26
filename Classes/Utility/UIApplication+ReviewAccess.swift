//
//  UIApplication+ReviewAccess.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIApplication {

    func openReviewAccess() {
        guard let url = URLBuilder.github()
            .add(paths: ["settings", "connections", "applications", Secrets.GitHub.clientId]).url
            else { return }
        open(url, options: [:])
    }

}
