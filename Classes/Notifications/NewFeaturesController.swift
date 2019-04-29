//
//  NewFeaturesController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/22/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI
import IGListKit

final class NewFeaturesController {

    // change to true for hardcoded testing
    private let testing = false
    private(set) var latestMarkdown: String?

    static var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    var version: String {
        if testing {
            return "test"
        }
        return NewFeaturesController.version
    }

    private var fetchURL: URL? {
        return URLBuilder(host: "raw.githubusercontent.com")
            .add(paths: ["GitHawkApp", "Release-Notes", "master", "versions", "\(version).md"])
            .url
    }

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        return URLSession.init(configuration: config)
    }()

    private let userDefaultsKey = "com.freetime.new-features-controller.has-fetched"

    private var hasFetchedLatest: Bool {
        get {
            guard let last = UserDefaults.standard.string(forKey: userDefaultsKey) else {
                return false
            }
            // value kept to latest version when seen
            // pinned to old versions (or empty) when out of date
            return last >= version
        }
        set {
            if newValue {
                UserDefaults.standard.set(version, forKey: userDefaultsKey)
            } else {
                UserDefaults.standard.removeObject(forKey: userDefaultsKey)
            }
        }
    }

    func fetch(success: @escaping () -> Void) {
        guard let url = fetchURL,
            (testing == true || hasFetchedLatest == false)
            else { return }
        hasFetchedLatest = true

        let task = session.dataTask(with: url) { (data, response, _) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async { [weak self] in
                    self?.latestMarkdown = string
                    success()
                }
            }
        }
        task.resume()
    }

}
