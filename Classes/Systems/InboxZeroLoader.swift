//
//  InboxZeroLoader.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

final class InboxZeroLoader {

    // [year/"fixed": [month: [day: [key:value]]]
    private typealias SerializedType = [String: [String: [String: [String: String]]]]
    private let path: String = {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return "\(path)/holidays.json"
    }()

    private lazy var json: SerializedType = {
        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SerializedType ?? [:]
    }()

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        return URLSession.init(configuration: config)
    }()

    private var url: URL? {
        return URL(
            string: "https://raw.githubusercontent.com/GitHawkApp/Holidays/master/locales/holidays-\(Locale.current.identifier).json"
        )
    }

    func load(completion: @escaping (Bool) -> Void) {
        guard let url = self.url else {
            completion(false)
            return
        }

        let path = self.path
        session.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data,
                let tmp = try? JSONSerialization.jsonObject(with: data, options: []) as? SerializedType,
                let json = tmp {
                DispatchQueue.main.async {
                    self?.json = json
                    completion(true)
                }
                NSKeyedArchiver.archiveRootObject(json, toFile: path)
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }

    private var fallback: (String, String) {
        return ("🎉", NSLocalizedString("Inbox zero!", comment: ""))
    }

    func message(date: Date = Date()) -> (emoji: String, message: String) {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        guard let day = components.day,
            let month = components.month,
            let year = components.year else {
                return fallback
        }

        // either key on the current year or "fixed" (for permanent dates)
        if let yearData = json["\(year)"] ?? json["fixed"],
            let monthData = yearData["\(month)"],
            let data = monthData["\(day)"],
            let emoji = data["emoji"],
            let message = data["message"] {
            return (emoji, message)
        }
        return fallback
    }

}
