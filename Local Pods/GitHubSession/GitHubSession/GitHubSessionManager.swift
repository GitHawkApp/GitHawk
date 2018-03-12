//
//  GitHubSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public protocol GitHubSessionListener: class {
    func didReceiveRedirect(manager: GitHubSessionManager, code: String)
    func didFocus(manager: GitHubSessionManager, userSession: GitHubUserSession, dismiss: Bool)
    func didLogout(manager: GitHubSessionManager)
}

public class GitHubSessionManager: NSObject {

    private class ListenerWrapper: NSObject {
        weak var listener: GitHubSessionListener?
    }
    private var listeners = [ListenerWrapper]()

    private enum Keys {
        enum v1 { static let session = "com.github.sessionmanager.session.1" }
        enum v2 { static let session = "com.github.sessionmanager.session.2" }
        enum v3 { static let session = "com.github.sessionmanager.shared.session" }
        static let latest = v3.session
    }

    private let _userSessions = NSMutableOrderedSet()
    private let defaults: UserDefaults

    public override init() {
        let nonSharedDefaults = UserDefaults.standard
        defaults = UserDefaults(suiteName: "group.com.whoisryannystrom.freetime") ?? .standard

        // Support migration outside of Freetime app workspace/module
        NSKeyedUnarchiver.setClass(GitHubUserSession.self, forClassName: "Freetime.GithubUserSession")

        // if a migration occurs, immediately save to disk
        var migrated = false

        if let v1data = nonSharedDefaults.object(forKey: Keys.v1.session) as? Data,
            let session = NSKeyedUnarchiver.unarchiveObject(with: v1data) as? GitHubUserSession {
            _userSessions.add(session)

            // clear the outdated session format
            nonSharedDefaults.removeObject(forKey: Keys.v1.session)
            migrated = true
        } else if let v2data = nonSharedDefaults.object(forKey: Keys.v2.session) as? Data,
            let session = NSKeyedUnarchiver.unarchiveObject(with: v2data) as? NSOrderedSet {
            _userSessions.union(session)

            // clear the outdated session format
            nonSharedDefaults.removeObject(forKey: Keys.v2.session)
            migrated = true
        } else if let v3data = defaults.object(forKey: Keys.v3.session) as? Data,
            let session = NSKeyedUnarchiver.unarchiveObject(with: v3data) as? NSOrderedSet {
            _userSessions.union(session)
        }

        super.init()

        if migrated {
            save()
        }
    }

    // MARK: Public API

    public var focusedUserSession: GitHubUserSession? {
        return _userSessions.firstObject as? GitHubUserSession
    }

    public var userSessions: [GitHubUserSession] {
        return _userSessions.array as? [GitHubUserSession] ?? []
    }

    public func addListener(listener: GitHubSessionListener) {
        let wrapper = ListenerWrapper()
        wrapper.listener = listener
        listeners.append(wrapper)
    }

    public func focus(
        _ userSession: GitHubUserSession,
        dismiss: Bool
        ) {
        _userSessions.remove(userSession)
        _userSessions.insert(userSession, at: 0)
        save()
        for wrapper in listeners {
            wrapper.listener?.didFocus(manager: self, userSession: userSession, dismiss: dismiss)
        }
    }

    public func logout() {
        _userSessions.removeAllObjects()
        save()
        for wrapper in listeners {
            wrapper.listener?.didLogout(manager: self)
        }
    }

    public func save() {
        if _userSessions.count > 0 {
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: _userSessions), forKey: Keys.latest)
        } else {
            defaults.removeObject(forKey: Keys.latest)
        }
    }

    public func receivedCodeRedirect(url: URL) {
        guard let items = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
            let index = items.index(where: { $0.name == "code" }),
            let code = items[index].value
            else { return }
        for wrapper in listeners {
            wrapper.listener?.didReceiveRedirect(manager: self, code: code)
        }
    }

}
