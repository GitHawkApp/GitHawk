//
//  UIApplication+WriteReview.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIApplication {

    @discardableResult
    func openWriteReview() -> Bool {
        guard let url = URLBuilder.init(host: "itunes.apple.com", scheme: "itms-apps")
            .add(paths: ["app", "id1252320249"])
            .add(item: "action", value: "write-review")
            .url
            else { return false }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return true
        }
        return false
    }

}
