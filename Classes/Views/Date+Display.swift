//
//  Date+Display.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Date {

    private enum Ago {
        case future(Int)
        case seconds(Int)
        case minutes(Int)
        case hours(Int)
        case days(Int)
        case months(Int)
        case years(Int)
    }

    private var ago: Ago {
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

    var agoString: String {
        switch ago {
        case .future: return NSLocalizedString("in the future", comment: "")
        case .seconds: return NSLocalizedString("just now", comment: "")
        case .minutes(let t):
            let format = NSLocalizedString("%d minute(s) ago", comment: "")
            return String(format: format, t)
        case .hours(let t):
            let format = NSLocalizedString("%d hour(s) ago", comment: "")
            return String(format: format, t)
        case .days(let t):
            let format = NSLocalizedString("%d day(s) ago", comment: "")
            return String(format: format, t)
        case .months(let t):
            let format = NSLocalizedString("%d month(s) ago", comment: "")
            return String(format: format, t)
        case .years(let t):
            let format = NSLocalizedString("%d year(s) ago", comment: "")
            return String(format: format, t)
        }
    }

}
