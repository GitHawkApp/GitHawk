//
//  UIViewController+UserActivity.swift
//  Freetime
//
//  Created by Bas Broek on 20/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol UserActivitySupporting {
    var activityName: String { get }
    var activityTitle: String { get }
}

struct HandoffInformator: UserActivitySupporting {
    let activityName: String
    let activityTitle: String
    let url: URL
}

extension UIViewController {

    func setupUserActivity(with informator: HandoffInformator) {
        let activity = NSUserActivity(activityType: "\(Bundle.main.bundleIdentifier ?? "").\(informator.activityTitle)")
        activity.title = NSLocalizedString(informator.activityTitle, comment: "")
        activity.webpageURL = informator.url
        activity.isEligibleForHandoff = true
        self.userActivity = activity
        self.userActivity?.becomeCurrent()
    }

    func resignUserActivity() {
        userActivity?.resignCurrent()
    }

    func invalidateUserActivity() {
        userActivity?.invalidate()
    }
}
