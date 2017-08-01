//
//  Freedom.swift
//  Freedom
//
//  Created by Sabintsev, Arthur on 7/2/17.
//  Copyright © 2017 Arthur Ariel Sabintsev. All rights reserved.
//

import UIKit

public final class Freedom {

    /// Third-Party Browsers Supported by Freedom
    ///
    /// - brave: Brave Browser (https://itunes.apple.com/us/app/brave-browser-fast-adblocker/id1052879175?mt=8)
    /// - chrome: Google Chrome (https://itunes.apple.com/us/app/google-chrome-the-fast-and-secure-web-browser/id535886823?mt=8)
    /// - dolphin: Dolphin Web Browser (https://itunes.apple.com/gb/app/dolphin-web-browser-fast-internet/id452204407?mt=8)
    /// - firefox: Firefox Web Browser (https://itunes.apple.com/us/app/firefox-web-browser/id989804926?mt=8)
    public enum Browser {
        case brave
        case chrome
        case dolphin
        case firefox
        case safari

        static var all: [Browser] {
            return [.safari, .brave, .chrome, .dolphin, .firefox]
        }
    }

    // Enables Debug Logs. Disabled by default.
    public static var debugEnabled = false

    /// An array of `UIActivity` instances that represent third-party browsers that
    /// can be used to open URLs in an instance of `UIActivityViewController`.
    ///
    /// - Parameter browsers: An array of `Browsers`. Defaults to all supported browsers if no parameters are provided.
    /// - Returns: Returns an array of UIActivities that the consumer would like to support in their app.
    public static func browsers(_ browsers: [Browser] = Browser.all) -> [UIActivity] {
        var activities: [UIActivity] = []

        if browsers.contains(.safari) {
            printDebugMessage("Freedom is initialized to support the Safari Browser.")
            activities.append(SafariFreedomActivity())
        }

        if browsers.contains(.brave) {
            printDebugMessage("Freedom is initialized to support the Brave Browser.")
            activities.append(BraveFreedomActivity())
        }

        if browsers.contains(.chrome) {
            printDebugMessage("Freedom is initialized to support the Google Chrome Browser.")
            activities.append(ChromeFreedomActivity())
        }

        if browsers.contains(.dolphin) {
            printDebugMessage("Freedom is initialized to support the Dolphin Web Browser.")
            activities.append(DolphinFreedomActivity())
        }

        if browsers.contains(.firefox) {
            printDebugMessage("Freedom is initialized to support the Firefox Web Browser.")
            activities.append(FirefoxFreedomActivity())
        }

        return activities
    }

}

// MARK: - Helpers

extension Freedom {

    /// References Freedom.bundle, which contains images for the various browser UIActivity instances.
    static var bundle: Bundle {
        let path = Bundle(for: Freedom.self).path(forResource: "Freedom", ofType: "bundle") ?? Bundle.main.bundlePath
        return Bundle(path: path) ?? Bundle.main
    }

    /// Prints a debug message if `debugEnabled` is set to `true`.
    ///
    /// - Parameters:
    ///   - message: The debug message to print
    ///   - file: The file from which the debug message originated.
    ///   - function: The function from which the debug message originated.
    ///   - line: The line number of the file from which the debug message originated.
    static func printDebugMessage(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        guard debugEnabled else { return }
        print("\(file).\(function)[\(line)]: \(message)")
    }

}
