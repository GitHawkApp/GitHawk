//
//  WatchAppUserSessionSync.swift
//  FreetimeWatch Extension
//
//  Created by Ryan Nystrom on 4/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import WatchConnectivity
import GitHubSession

public protocol WatchAppUserSessionSyncDelegate: class {
    func sync(_ sync: WatchAppUserSessionSync, didReceive userSession: GitHubUserSession)
}

public class WatchAppUserSessionSync: NSObject, WCSessionDelegate {

    public weak var delegate: WatchAppUserSessionSyncDelegate?

    private let userSession: GitHubUserSession?
    private let session: WCSession
    private let key = "com.freetime.watchappsync.usersession"

    public init?(userSession: GitHubUserSession? = nil) {
        guard WCSession.isSupported() else { return nil }
        self.session = WCSession.default
        self.userSession = userSession
    }

    public func start() {
        session.delegate = self
        session.activate()
    }

    public var lastSyncedUserSession: GitHubUserSession?  {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? GitHubUserSession
    }

    // https://forums.developer.apple.com/thread/11658
    public func sync(userSession: GitHubUserSession) {
        for transfer in session.outstandingUserInfoTransfers {
            if transfer.userInfo[key] != nil {
                transfer.cancel()
            }
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: userSession)
        validSession?.transferUserInfo([key: data])
    }

    // MARK: Private API

    // https://www.natashatherobot.com/watchconnectivity-user-info/
    private var validSession: WCSession? {
        #if !os(watchOS)
        guard session.isPaired && session.isWatchAppInstalled else {
            return nil
        }
        #endif
        return session
    }

    // MARK: WCSessionDelegate

    public func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
        ) {
        if let error = error {
            print(error)
        }

        // don't auto sync if on watchOS
        #if !os(watchOS)
        if let userSession = self.userSession {
            sync(userSession: userSession)
        }
        #endif
    }

    #if !os(watchOS)
    public func sessionDidBecomeInactive(_ session: WCSession) {}
    public func sessionDidDeactivate(_ session: WCSession) {}
    #endif

    // will only run on the watch
    public func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let data = userInfo[key] as? Data,
            let userSession = NSKeyedUnarchiver.unarchiveObject(with: data) as? GitHubUserSession {
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()

            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.delegate?.sync(strongSelf, didReceive: userSession)
            }
        }
    }

}
