//
//  Date+Ago.swift
//  DateAgo
//
//  Created by Ryan Nystrom on 4/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Date {

    internal enum Ago {
        case future(Int)
        case seconds(Int)
        case minutes(Int)
        case hours(Int)
        case days(Int)
        case months(Int)
        case years(Int)
    }

    internal var ago: Ago {
        let seconds = timeIntervalSinceNow
        if seconds > 0 {
            return Ago.future(Int(seconds))
        } else {
            // negative and casted so other values are implied
            let minute: TimeInterval = -60
            let hour: TimeInterval = minute * 60
            let day: TimeInterval = hour * 24
            let month: TimeInterval = day * 30
            let year: TimeInterval = month * 12

            switch seconds {
            case minute+1 ... 0:
                return Ago.seconds(Int(seconds))
            case hour+1 ..< minute+1:
                return Ago.minutes(Int(round(seconds / minute)))
            case day+1 ..< hour+1:
                return Ago.hours(Int(round(seconds / hour)))
            case month+1 ..< day+1:
                return Ago.days(Int(round(seconds / day)))
            case year+1 ..< month+1:
                return Ago.months(Int(round(seconds / month)))
            default:
                return Ago.years(Int(round(seconds / year)))
            }
        }
    }

}
