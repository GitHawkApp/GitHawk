//
//  GitHubSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol GithubSessionListener: class {
    func didReceiveRedirect(manager: GithubSessionManager, code: String)
    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession, dismiss: Bool)
    func didLogout(manager: GithubSessionManager)
}

final class GithubSessionManager: NSObject, ListDiffable {

    private class ListenerWrapper: NSObject {
        weak var listener: GithubSessionListener? = nil
    }
    private var listeners = [ListenerWrapper]()

    private enum Keys {
        enum v1 {
            static let session = "com.github.sessionmanager.session.1"
        }
        enum v2 {
            static let session = "com.github.sessionmanager.session.2"
        }
    }

    private let _userSessions = NSMutableOrderedSet()
    private let defaults = UserDefaults.standard

    override init() {
        // if a migration occurs, immediately save to disk
        var migrated = false

        if let sample = sampleUserSession() {
            _userSessions.add(sample)
        } else if let v1data = defaults.object(forKey: Keys.v1.session) as? Data,
            let session = NSKeyedUnarchiver.unarchiveObject(with: v1data) as? GithubUserSession {
            _userSessions.add(session)

            // clear the outdated session format
            defaults.removeObject(forKey: Keys.v1.session)
            migrated = true
        } else if let v2data = defaults.object(forKey: Keys.v2.session) as? Data,
            let session = NSKeyedUnarchiver.unarchiveObject(with: v2data) as? NSOrderedSet {
            _userSessions.union(session)
        }

        super.init()

        if migrated {
            save()
        }
    }

    // MARK: Public API

    var focusedUserSession: GithubUserSession? {
        return _userSessions.firstObject as? GithubUserSession
    }

    var userSessions: [GithubUserSession] {
        return _userSessions.array as? [GithubUserSession] ?? []
    }

    func addListener(listener: GithubSessionListener) {
        let wrapper = ListenerWrapper()
        wrapper.listener = listener
        listeners.append(wrapper)
    }

    public func focus(
        _ userSession: GithubUserSession,
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

    func save() {
        if _userSessions.count > 0 {
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: _userSessions), forKey: Keys.v2.session)
        } else {
            defaults.removeObject(forKey: Keys.v2.session)
        }
    }

    func receivedCodeRedirect(url: URL) {
        guard let code = url.absoluteString.valueForQuery(key: "code") else { return }
        for wrapper in listeners {
            wrapper.listener?.didReceiveRedirect(manager: self, code: code)
        }
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object
    }

}
