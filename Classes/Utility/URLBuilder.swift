//
//  URLBuilder.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

final class URLBuilder {

    private var components = URLComponents()
    private var pathComponents = [String]()

    init(host: String, https: Bool = true) {
        components.host = host
        components.scheme = https ? "https" : "http"
    }

    static func github() -> URLBuilder {
        return URLBuilder(host: "github.com", https: true)
    }

    func add(path: String) -> URLBuilder {
        pathComponents.append(path)
        return self
    }

    func add(query item: String, value: LosslessStringConvertible) -> URLBuilder {
        var items = components.queryItems ?? []
        items.append(URLQueryItem(name: item, value: String(describing: value)))
        components.queryItems = items
        return self
    }

    var url: URL? {
        var components = self.components
        if !pathComponents.isEmpty {
            components.path = "/" + pathComponents.joined(separator: "/")
        }
        return components.url
    }

}
