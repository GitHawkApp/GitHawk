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

    private(set) var authorization: Authorization?

    override init() {
        if let data = defaults.object(forKey: key) as? Data {
            authorization = NSKeyedUnarchiver.unarchiveObject(with: data) as? Authorization
        }
        super.init()
    }

    func add(authorization: Authorization) {
        self.authorization = authorization
        save()
        for listener in listeners.allObjects {
            listener.didAdd(session: self, authorization: authorization)
        }
    }

    func remove() {
        guard let authorization = authorization else { return }
        self.authorization = nil
        save()
        for listener in listeners.allObjects {
            listener.didRemove(session: self, authorization: authorization)
        }
    }

    func save() {
        if let auth = authorization {
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: auth), forKey: key)
        } else {
            defaults.removeObject(forKey: key)
        }
    }

}
