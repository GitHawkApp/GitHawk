//
//  GitHubSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

enum GithubSessionResult {
    case unchanged
    case changed(GithubUserSession)
    case logout
}

protocol GithubSessionListener: class {
    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession)
    func didRemove(manager: GithubSessionManager, userSessions: [GithubUserSession], result: GithubSessionResult)
}

extension GithubUserSession {
    var collectionKey: String {
        return login
    }
}

final class GithubSessionManager: NSObject, IGListDiffable {

    private class ListenerWrapper: NSObject {
        weak var listener: GithubSessionListener? = nil
    }
    private var listeners = [ListenerWrapper]()

    private struct Keys {
        static let sessions = "com.github.sessionmanager.sessions"
        static let focused = "com.github.sessionmanager.focused"
    }

    typealias SessionCollection = [String: GithubUserSession]
    private var _focusedKey: String? = nil
    private var _userSessions = SessionCollection()
    private let defaults = UserDefaults.standard

    override init() {
        if let data = defaults.object(forKey: Keys.sessions) as? Data,
            let sessions = NSKeyedUnarchiver.unarchiveObject(with: data) as? SessionCollection {
            _userSessions = sessions
        }
        _focusedKey = defaults.object(forKey: Keys.focused) as? String
        super.init()
    }

    // MARK: Public API

    func addListener(listener: GithubSessionListener) {
        let wrapper = ListenerWrapper()
        wrapper.listener = listener
        listeners.append(wrapper)
    }

    public var focusedLogin: String? {
        return _focusedKey
    }

    public var focusedUserSession: GithubUserSession? {
        guard let focusedKey = _focusedKey else { return nil }
        return _userSessions[focusedKey]
    }

    public var allUserSessions: [GithubUserSession] {
        return _userSessions.map { $0.1 }
    }

    public func focus(_ userSession: GithubUserSession) {
        let key = userSession.collectionKey
        _focusedKey = key
        _userSessions[key] = userSession
        save()
        for wrapper in listeners {
            wrapper.listener?.didFocus(manager: self, userSession: userSession)
        }
    }

    func remove(_ userSessions: [GithubUserSession]) {
        let keys = userSessions.map { $0.collectionKey }

        var removed = [GithubUserSession]()
        for key in keys {
            if let session = _userSessions.removeValue(forKey: key) {
                removed.append(session)
            }
            if _focusedKey == key {
                _focusedKey = nil
            }
        }

        save()

        let result: GithubSessionResult
        if _userSessions.count == 0 {
            result = .logout
        } else if _focusedKey == nil,
            let newFocus = allUserSessions.first?.collectionKey,
        let newFocusedSession = _userSessions[newFocus] {
            _focusedKey = newFocus
            result = .changed(newFocusedSession)
        } else {
            result = .unchanged
        }

        for wrapper in listeners {
            wrapper.listener?.didRemove(manager: self, userSessions: removed, result: result)
        }
    }

    func save() {
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: _userSessions), forKey: Keys.sessions)
        defaults.set(_focusedKey, forKey: Keys.focused)
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return self === object
    }

}
