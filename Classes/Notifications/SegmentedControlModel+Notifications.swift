//
//  SegmentedControlModel+Notifications.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension SegmentedControlModel {

    static func forNotifications() -> SegmentedControlModel {
        return SegmentedControlModel(items: [Constants.Strings.unread, Constants.Strings.all])
    }

    var unreadSelected: Bool {
        return items[selectedIndex] == Constants.Strings.unread
    }

}
