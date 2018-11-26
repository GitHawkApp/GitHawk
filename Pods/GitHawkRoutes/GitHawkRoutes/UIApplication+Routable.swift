//
//  UIApplication+Routable.swift
//  GitHawkRoutes
//
//  Created by Ryan Nystrom on 10/19/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

public extension UIApplication {

    public func open<T: Routable>(
        githawk route: T,
        completion: ((Bool) -> Void)? = nil
        ) {

        guard let url = URL.from(githawk: route),
            canOpenURL(url)
            else {
                completion?(false)
                return
        }
        if #available(iOS 10.0, *) {
            open(url, options: [:], completionHandler: completion)
        } else {
            let result = openURL(url)
            completion?(result)
        }
    }

}


