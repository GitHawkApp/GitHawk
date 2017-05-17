//
//  GitHubSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

@objc protocol GithubSessionListener {
    func didAdd(session: GithubSession, authorization: Authorization)
    func didRemove(session: GithubSession, authorization: Authorization)
}

final class GithubSession: NSObject {

    private let key = "com.github.session"
    private let defaults = UserDefaults.standard
    private let listeners = NSHashTable<GithubSessionListener>.weakObjects()

    func addListener(listener: GithubSessionListener) {
        listeners.add(listener)
    }

    func removeListener(listener: GithubSessionListener) {
        listeners.remove(listener)
    }

    private var _authorizations = [Authorization]()

    override init() {
        if let data = defaults.object(forKey: key) as? Data,
            let auths = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Authorization] {
            _authorizations = auths
        }
        super.init()
    }

    // MARK: Public API

    public func authorizations() -> [Authorization] {
        return _authorizations
    }

    public func add(authorization: Authorization) {
        _authorizations.append(authorization)
        save()
        for listener in listeners.allObjects {
            listener.didAdd(session: self, authorization: authorization)
        }
    }

    func remove(authorization: Authorization) {
        // search for auth match by comparing the tokens. linear search but simple.
        var index = NSNotFound
        for (i, auth) in _authorizations.enumerated() {
            if auth.token == authorization.token {
                index = i
            }
        }
        guard index < _authorizations.count else { return }
        _authorizations.remove(at: index)

        save()
        for listener in listeners.allObjects {
            listener.didRemove(session: self, authorization: authorization)
        }
    }

    func save() {
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: _authorizations), forKey: key)
    }

}
