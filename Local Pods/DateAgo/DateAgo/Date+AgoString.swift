//
//  Date+AgoString.swift
//  DateAgo
//
//  Created by Ryan Nystrom on 4/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public extension Date {

    enum AgoFormat {
        case short
        case long
    }

    private static let dateFormatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.unitsStyle = .abbreviated
        return f
    }()

    private static let bundle: Bundle = {
        return Bundle(identifier: "com.whoisryannystrom.DateAgo") ?? Bundle.main
    }()

    // FIXME: Add language plural rules
    // https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LocalizingYourApp/LocalizingYourApp.html#//apple_ref/doc/uid/10000171i-CH5-SW10
    func agoString(_ format: AgoFormat = .long) -> String {
        switch ago {
        case .future:
            return NSLocalizedString("in the future", bundle: Date.bundle, comment: "")
        case .seconds:
            switch format {
            case .long:
                return NSLocalizedString("just now", bundle: Date.bundle, comment: "")
            case .short:
                return NSLocalizedString("now", bundle: Date.bundle, comment: "")
            }
        case .minutes(let t):
            switch format {
            case .long:
                let format = NSLocalizedString("%d minute(s) ago", bundle: Date.bundle, comment: "")
                return String(format: format, t)
            case .short:
                return Date.dateFormatter.string(from: DateComponents(minute: t)) ?? "\(t)"
            }
        case .hours(let t):
            switch format {
            case .long:
                let format = NSLocalizedString("%d hour(s) ago", bundle: Date.bundle, comment: "")
                return String(format: format, t)
            case .short:
                return Date.dateFormatter.string(from: DateComponents(hour: t)) ?? "\(t)"
            }
        case .days(let t):
            switch format {
            case .long:
                let format = NSLocalizedString("%d day(s) ago", bundle: Date.bundle, comment: "")
                return String(format: format, t)
            case .short:
                return Date.dateFormatter.string(from: DateComponents(day: t)) ?? "\(t)"
            }
        case .months(let t):
            switch format {
            case .long:
                let format = NSLocalizedString("%d month(s) ago", bundle: Date.bundle, comment: "")
                return String(format: format, t)
            case .short:
                return Date.dateFormatter.string(from: DateComponents(month: t)) ?? "\(t)"
            }
        case .years(let t):
            switch format {
            case .long:
                let format = NSLocalizedString("%d year(s) ago", bundle: Date.bundle, comment: "")
                return String(format: format, t)
            case .short:
                return Date.dateFormatter.string(from: DateComponents(year: t)) ?? "\(t)"
            }
        }
    }

}
