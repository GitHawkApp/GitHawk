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
    func didAuthenticate(manager: GithubSessionManager, userSession: GithubUserSession)
    func didLogout(manager: GithubSessionManager)
}

final class GithubSessionManager: NSObject, ListDiffable {

    private class ListenerWrapper: NSObject {
        weak var listener: GithubSessionListener? = nil
    }
    private var listeners = [ListenerWrapper]()

    private enum Keys {
        static let version = "1"
        static let session = "com.github.sessionmanager.session.\(Keys.version)"
    }

    private(set) var userSession: GithubUserSession?
    private let defaults = UserDefaults.standard

    override init() {
        if let sample = sampleUserSession() {
            userSession = sample
        } else if let data = defaults.object(forKey: Keys.session) as? Data,
            let session = NSKeyedUnarchiver.unarchiveObject(with: data) as? GithubUserSession {
            userSession = session
        }
        super.init()
    }

    // MARK: Public API

    func addListener(listener: GithubSessionListener) {
        let wrapper = ListenerWrapper()
        wrapper.listener = listener
        listeners.append(wrapper)
    }

    public func authenticate(_ token: String, authMethod: GithubUserSession.AuthMethod) {
        let userSession = GithubUserSession(token: token, authMethod: authMethod)
        self.userSession = userSession
        save()
        for wrapper in listeners {
            wrapper.listener?.didAuthenticate(manager: self, userSession: userSession)
        }
    }

    public func logout() {
        userSession = nil
        save()
        for wrapper in listeners {
            wrapper.listener?.didLogout(manager: self)
        }
    }

    func save() {
        if let session = userSession {
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: session), forKey: Keys.session)
        } else {
            defaults.removeObject(forKey: Keys.session)
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
