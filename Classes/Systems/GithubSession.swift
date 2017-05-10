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

    private var authorizations: NSMutableOrderedSet

    override init() {
        if let data = defaults.object(forKey: key) as? Data,
            let auths = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSMutableOrderedSet {
            authorizations = auths
        } else {
            authorizations = NSMutableOrderedSet()
        }
        super.init()
    }

    var currentAuthorization: Authorization? {
        return authorizations.firstObject as? Authorization
    }

    func add(authorization: Authorization) {
        authorizations.add(authorization)
        for listener in listeners.allObjects {
            listener.didAdd(session: self, authorization: authorization)
        }
    }

    func remove(authorization: Authorization) {
        authorizations.remove(authorization)
        for listener in listeners.allObjects {
            listener.didRemove(session: self, authorization: authorization)
        }
    }

    func save() {
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: authorizations), forKey: key)
    }

}
