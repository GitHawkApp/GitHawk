//
//  NotificationReason.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum NotificationReason: String {

    case assign = "assign"
    case author = "author"
    case comment = "comment"
    case invitation = "invitation"
    case manual = "manual"
    case mention = "mention"
    case state_change = "state_change"
    case subscribed = "subscribed"
    case team_mention = "team_mention"
    case unknown

}
