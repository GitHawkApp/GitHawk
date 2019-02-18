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
    typealias SerializedType = [String: [String: [String: [String: String]]]]
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
        return URLBuilder(host: "raw.githubusercontent.com").add(paths: [
            "GitHawkApp", "Holidays", "master", "locales", "holidays-\(Locale.current.identifier).json"
            ]).url
    }

    init(json: SerializedType? = nil) {
        json.flatMap { self.json = $0 }
    }

    func load(completion: @escaping (Bool) -> Void) {
        guard let url = self.url else {
            completion(false)
            return
        }

        let path = self.path
        session.dataTask(with: url) { [weak self] (data, _, _) in
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

    // either key on the current year or "fixed" (for permanent dates)
    private func holiday(year: Int, month: Int, day: Int) -> [String: String]? {
        let holidays: (String) -> [String: String]? = {
            return self.json[$0]?["\(month)"]?["\(day)"]
        }
        return holidays("\(year)") ?? holidays("fixed")
    }

    func message(date: Date = Date()) -> (emoji: String, message: String) {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        guard let day = components.day,
            let month = components.month,
            let year = components.year else {
                return fallback
        }

        if let holiday = holiday(year: year, month: month, day: day),
            let emoji = holiday["emoji"],
            let message = holiday["message"] {
            return (emoji, message)
        }
        return fallback
    }

}
