//
//  LocalNotificationsCache.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/26/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import FMDB
import GitHubAPI

final class LocalNotificationsCache {

    private let path: String = {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return "\(path)/read-notifications.sqlite"
    }()
    private lazy var queue: FMDatabaseQueue = {
        return FMDatabaseQueue(path: self.path)
    }()
    private let defaults = UserDefaults.standard
    private let setupKey = "com.whoisryannystrom.freetime.local-notifications.setup"
    private let table = "read-notifications"
    private let apiCol = "apiID"
    private let idCol = "id"

    private var isFirstSetup: Bool {
        return defaults.bool(forKey: setupKey)
    }

    func update(
        notifications: [V3Notification],
        completion: (([V3Notification]) -> Void)?
        ) {
        guard notifications.count > 0 else {
            completion?([])
            return
        }

        queue.inDatabase { db in
            let table = "read-notifications"
            let apiCol = "apiID"
            let idCol = "id"

            var map = [String: V3Notification]()
            notifications.forEach { map[$0.id] = $0 }
            let apiIDs = map.keys.map { $0 }
            let sanitized = map.keys.map { _ in "?" }.joined(separator: ", ")

            do {
                // attempt to create the table
                try db.executeUpdate(
                    "create table \(table) if not exists (\(idCol) integer primary key autoincrement, \(apiCol) text",
                    values: nil
                )

                // if handling unseen, remove notifications that already exist
                if completion != nil {
                    let rs = try db.executeQuery(
                        "select \(apiCol) from \(table) where \(apiCol) in (\(sanitized))",
                        values: apiIDs
                    )
                    while rs.next() {
                        if let key = rs.string(forColumn: apiCol) {
                            map.removeValue(forKey: key)
                        }
                    }
                }

                // add latest notification ids in the db
                try db.executeUpdate(
                    "insert into \(table) (\(apiCol)) values (\(sanitized))",
                    values: apiIDs
                )

                // cap the local database to latest 1000 notifications
                try db.executeUpdate(
                    "delete from \(table) where \(idCol) not in (select \(idCol) from \(table) order by \(idCol) desc limit 1000)",
                    values: nil
                )
            } catch {
                print("failed: \(error.localizedDescription)")
            }

            completion?(map.values.map { $0 })
        }
    }

}
