//
//  Router.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHawkRoutes

private func register<T: Routable & RoutePerformable>(
    route: T.Type,
    map: inout [String: (Routable & RoutePerformable).Type]
    ) {
    map[T.path] = T.self
}

protocol RouterDelegate: class {
    func perform(route: RoutePerformable, router: Router) -> Bool
}

final class Router {

    private weak var delegate: RouterDelegate?
    private let routes: [String: (Routable & RoutePerformable).Type]

    init(delegate: RouterDelegate) {
        var routes = [String: (Routable & RoutePerformable).Type]()
        register(route: BookmarkShortcutRoute.self, map: &routes)
        register(route: SwitchAccountShortcutRoute.self, map: &routes)
        register(route: SearchShortcutRoute.self, map: &routes)
        register(route: IssueRoute.self, map: &routes)
        register(route: RepoRoute.self, map: &routes)
        self.routes = routes
        self.delegate = delegate
    }

    @discardableResult
    func handle(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let host = components.host
            else { return false }
        var params = [String: String]()
        for item in components.queryItems ?? [] {
            params[item.name] = item.value
        }
        return handle(path: host, params: params)
    }

    @discardableResult
    func handle(path: String, params: [String: String]) -> Bool {
        guard let routeType = routes[path],
            let route = routeType.from(params: params),
            let delegate = self.delegate
            else { return false }
        return delegate.perform(route: route, router: self)
    }

}
