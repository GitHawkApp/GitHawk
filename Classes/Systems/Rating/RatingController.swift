//
//  RatingController.swift
//  GitHawk
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

    enum Prompt {
        case inFeed
        case system
    }

    // MARK: Public API

    class func applicationDidLaunch() {
        guard storage.object(forKey: Keys.install) == nil else { return }
        storage.set(Date(), forKey: Keys.install)
    }

    class func inFeedToken() -> RatingToken? {
        guard canPrompt(.inFeed) else { return nil }
        return RatingToken()
    }

    class func prompted() {
        storage.set(Date(), forKey: Keys.lastPrompt)
        storage.set(version, forKey: Keys.lastVerion)
    }

    class func prompt(_ type: Prompt) {
        guard canPrompt(.system) else { return }
        
        switch type {
        case .system: requestSystem()
        case .inFeed: openAppStore()
        }
    }

    // MARK: Private API

    private class func requestSystem() {
        if #available(iOS 10.3, *) {
            prompted()
            SKStoreReviewController.requestReview()
        }
    }

    private class func openAppStore() {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id1252320249?action=write-review")
            else { return }
        prompted()
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private static let storage = UserDefaults.standard
    private static let version = Bundle.main.versionNumber
    private static let debugging = false

    private class func canPrompt(_ type: Prompt) -> Bool {
        guard debugging == false else { return true }

        let day: TimeInterval = -1 * 60 * 60 * 24
        let minInstall: TimeInterval

        // system prompt is a much nicer experience, lower the threshold so should occur before in-feed
        switch type {
        case .system: minInstall = day * 3
        case .inFeed: minInstall = day * 7
        }

        guard let install = storage.object(forKey: Keys.install) as? Date,
            install.timeIntervalSinceNow < minInstall
            else { return false }

        guard let lastPrompt = storage.object(forKey: Keys.lastPrompt) as? Date,
            let lastVersion = storage.object(forKey: Keys.lastVerion) as? String
            else { return true }

        let interval: TimeInterval
        switch type {
        case .inFeed: interval = day * 45 // 1.5mo btwn feed prompts
        case .system: interval = day * 30 // max 3 per year per StoreKit API
        }

        // never prompt w/in the same version
        return lastVersion != version
            // limit all types of prompts to at least 1mo intervals
            && lastPrompt.timeIntervalSinceNow < interval
    }
    
}
