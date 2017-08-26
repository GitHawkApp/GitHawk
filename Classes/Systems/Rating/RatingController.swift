//
//  RatingController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import StoreKit
import IGListKit

final class RatingToken: NSObject, ListDiffable {

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}

final class RatingController {

    private enum Keys {
        static let lastPrompt = "com.freetime.RatingController.last-prompt"
        static let lastVerion = "com.freetime.RatingController.last-version"
        static let install = "com.freetime.RatingController.install"
    }

    // MARK: Public API

    class func applicationDidLaunch() {
        guard storage.object(forKey: Keys.install) == nil else { return }
        storage.set(Date(), forKey: Keys.install)
    }

    class func requestSystem() {
        guard canPrompt() else { return }

        if #available(iOS 10.3, *) {
            prompted()
            SKStoreReviewController.requestReview()
        }
    }

    class func token() -> RatingToken? {
        guard canPrompt() else { return nil }
        return RatingToken()
    }

    class func prompted() {
        storage.set(Date(), forKey: Keys.lastPrompt)
        storage.set(version, forKey: Keys.lastVerion)
    }

    // MARK: Private API

    private static let storage = UserDefaults.standard
    private static let version = Bundle.main.versionNumber

    private class func canPrompt() -> Bool {
        guard let install = storage.object(forKey: Keys.install) as? Date,
            // wait until 1w after install before prompting
            install.timeIntervalSinceNow < -1 * 60 * 60 * 24 * 7
            else { return false }

        guard let lastPrompt = storage.object(forKey: Keys.lastPrompt) as? Date,
            let lastVersion = storage.object(forKey: Keys.lastVerion) as? String
            else { return true }

        // never prompt w/in the same version
        return lastVersion != version
            // limit all types of prompts to at least 1mo intervals
            && lastPrompt.timeIntervalSinceNow < -1 * 60 * 60 * 24 * 30
    }
    
}
