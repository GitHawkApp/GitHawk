//
//  ChromeFreedomActivity.swift
//  Freedom
//
//  Created by Sabintsev, Arthur on 7/1/17.
//  Copyright © 2017 Arthur Ariel Sabintsev. All rights reserved.
//

import UIKit

final class ChromeFreedomActivity: UIActivity, FreedomActivating {

    override class var activityCategory: UIActivityCategory {
        return .action
    }

    override var activityImage: UIImage? {
        return UIImage(named: "chrome", in: Freedom.bundle, compatibleWith: nil)
    }

    override var activityTitle: String? {
        return "Open in Chrome"
    }

    override var activityType: UIActivityType? {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            Freedom.printDebugMessage("Failed to fetch the bundleID.")
            return nil
        }

        let type = bundleID + "." + String(describing: ChromeFreedomActivity.self)
        return UIActivityType(rawValue: type)
    }

    var activityDeepLink: String? = "googlechrome://"

    var activityURL: URL? {
        didSet {
            guard let scheme = activityURL?.scheme else {
                Freedom.printDebugMessage("The URL scheme is missing. This happens if a URL does not contain `http://` or `https://`.")
                return
            }
            switch scheme {
            case URLComponents.Schemes.https:
                activityDeepLink = "googlechromes://"
            default:
                break
            }
        }
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {

            guard let deepLinkURLString = activityDeepLink,
                let deepLinkURL = URL(string: deepLinkURLString),
                UIApplication.shared.canOpenURL(deepLinkURL) else {
                    return false
            }

            guard let url = item as? URL else {
               continue
            }

            guard url.conformToHypertextProtocol() else {
                Freedom.printDebugMessage("The URL scheme is missing. This happens if a URL does not contain `http://` or `https://`.")
                return false
            }

            Freedom.printDebugMessage("The user has Google Chrome installed.")
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

        guard let deepLink = activityDeepLink,
            let formattedURL = activityURL.withoutScheme(),
            let url = URL(string: deepLink + formattedURL.absoluteString) else {
                return activityDidFinish(false)
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:]) { [unowned self] opened in
                guard opened else {
                    return self.activityDidFinish(false)
                }
                Freedom.printDebugMessage("The user successfully opened the url, \(formattedURL.absoluteString), in Google Chrome.")
            }
        } else {
            UIApplication.shared.openURL(url)
            Freedom.printDebugMessage("The user successfully opened the url, \(formattedURL.absoluteString), in Google Chrome.")
        }
        
        activityDidFinish(true)
    }
}
