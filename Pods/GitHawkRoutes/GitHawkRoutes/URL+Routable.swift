//
//  URL+Routable.swift
//  GitHawkRoutes
//
//  Created by Ryan Nystrom on 10/31/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

internal extension URL {

    static func from<T: Routable>(githawk route: T) -> URL? {
        var components = URLComponents()
        components.scheme = "freetime"
        components.host = T.path
        components.queryItems = route.encoded.map(URLQueryItem.init)
        return components.url
    }

}
