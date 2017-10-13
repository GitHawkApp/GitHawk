//
//  SegmentedControlModel+Notifications.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension SegmentedControlModel {

    static func forNotifications() -> SegmentedControlModel {
        return SegmentedControlModel(items: [Strings.unread, Strings.all])
    }

    var unreadSelected: Bool {
        return items[selectedIndex] == Strings.unread
    }

}
