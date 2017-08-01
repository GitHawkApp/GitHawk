//
//  SafariFreedomActivity.swift
//  Freedom
//
//  Created by Arthur Sabintsev on 7/3/17.
//  Copyright © 2017 Arthur Ariel Sabintsev. All rights reserved.
//

import UIKit

final class SafariFreedomActivity: UIActivity, FreedomActivating {

    override class var activityCategory: UIActivityCategory {
        return .action
    }

    override var activityImage: UIImage? {
        return UIImage(named: "safari", in: Freedom.bundle, compatibleWith: nil)
    }

    override var activityTitle: String? {
        return "Open in Safari"
    }

    override var activityType: UIActivityType? {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            Freedom.printDebugMessage("Failed to fetch the bundleID.")
            return nil
        }

        let type = bundleID + "." + String(describing: SafariFreedomActivity.self)
        return UIActivityType(rawValue: type)
    }

    var activityDeepLink: String?

    var activityURL: URL?

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {

            guard let url = item as? URL else {
                continue
            }

            guard url.conformToHypertextProtocol() else {
                Freedom.printDebugMessage("The URL scheme is missing. This happens if a URL does not contain `http://` or `https://`.")
                return false
            }

            Freedom.printDebugMessage("The user has the Safari Web Browser installed.")
            return true
        }

        return false
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        activityItems.forEach { item in
            guard let url = item as? URL, url.conformToHypertextProtocol() else {
                return Freedom.printDebugMessage("The URL scheme is missing. This happens if a URL does not contain `http://` or `https://`.")
            }

            let urlString = url.absoluteString

            guard let escapedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                let escapedURL = URL(string: escapedURLString) else {
                    return Freedom.printDebugMessage("Failed to optionally unwrap a percent-encoded url.")
            }

            activityURL = escapedURL
            return
        }
    }

    override func perform() {
        guard let activityURL = activityURL else {
            Freedom.printDebugMessage("activityURL is missing.")
            return activityDidFinish(false)
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(activityURL, options: [:]) { [unowned self] opened in
                guard opened else {
                    return self.activityDidFinish(false)
                }
                Freedom.printDebugMessage("The user successfully opened the url, \(activityURL.absoluteString), in the Safari Web Browser.")
            }
        } else {
            UIApplication.shared.openURL(activityURL)
            Freedom.printDebugMessage("The user successfully opened the url, \(activityURL.absoluteString), in the Safari Web Browser.")
        }
        
        activityDidFinish(true)
    }
}

