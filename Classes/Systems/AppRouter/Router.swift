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

extension UIViewController {
    private static var RouterAssocObjectKey = "RouterAssocObjectKey"
    fileprivate var router: Router? {
        get {
            return objc_getAssociatedObject(
                self,
                &UIViewController.RouterAssocObjectKey
            ) as? Router
        }
        set {
            objc_setAssociatedObject(
                self,
                &UIViewController.RouterAssocObjectKey,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    func route_push(route: Routable & RoutePerformable) {
        router?.handle(route: route, from: self)
    }

    func route_detail(route: Routable & RoutePerformable) {
        router?.handle(route: route, from: nil)
    }

    // MARK: Remove after migration

    func route_push(to controller: UIViewController) {
        router?.push(from: self, to: controller)
    }

    func route_detail(to controller: UIViewController) {
        router?.detail(controller: controller)
    }

}

protocol RouterPropsSource: class {
    func props(for router: Router) -> RoutePerformableProps?
}

final class Router: NSObject {

    private weak var propsSource: RouterPropsSource?
    private let routes: [String: (Routable & RoutePerformable).Type]

    init(propsSource: RouterPropsSource) {
        var routes = [String: (Routable & RoutePerformable).Type]()
        register(route: BookmarkShortcutRoute.self, map: &routes)
        register(route: SwitchAccountShortcutRoute.self, map: &routes)
        register(route: SearchShortcutRoute.self, map: &routes)
        register(route: IssueRoute.self, map: &routes)
        register(route: RepoRoute.self, map: &routes)
        self.routes = routes
        self.propsSource = propsSource
    }

    func handle(url: URL) -> RoutePerformableResult {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let host = components.host
            else { return .error }
        var params = [String: String]()
        for item in components.queryItems ?? [] {
            params[item.name] = item.value
        }
        return handle(path: host, params: params)
    }

    @discardableResult
    func handle(path: String, params: [String: String]) -> RoutePerformableResult {
        guard let routeType = routes[path],
            let route = routeType.from(params: params)
            else { return .error }
        return handle(route: route)
    }

    // returning .show(controller) displays the controller in the detail view
    func handle(route: Routable & RoutePerformable) -> RoutePerformableResult {
        return handle(route: route, from: nil)
    }

    // returning the .show(controller) pushes the controller onto the nav stack
    // if a from controller is present
    @discardableResult
    func handle(
        route: Routable & RoutePerformable,
        from controller: UIViewController?
        ) -> RoutePerformableResult {
        guard let props = propsSource?.props(for: self) else { return .error }
        let result = route.perform(props: props)
        switch result {
        case .custom, .error: break
        case .show(let toController):
            if let controller = controller {
                push(from: controller, to: toController)
            } else {
                detail(controller: toController, split: props.splitViewController)
            }
        }
        return result
    }

    func push(from: UIViewController, to: UIViewController) {
        to.router = self
        from.navigationController?.pushViewController(
            to,
            animated: trueUnlessReduceMotionEnabled
        )
    }

    func detail(controller: UIViewController) {
        guard let split = propsSource?.props(for: self)?.splitViewController
            else { return }
        detail(controller: controller, split: split)
    }

    private func detail(controller: UIViewController, split: UISplitViewController) {
        controller.router = self
        let wrapped: UINavigationController
        if let controller = controller as? UINavigationController {
            controller.viewControllers.forEach { $0.router = self }
            wrapped = controller
        } else {
            wrapped = UINavigationController(rootViewController: controller)
            wrapped.router = self
        }
        split.showDetailViewController(wrapped, sender: nil)
    }

}
