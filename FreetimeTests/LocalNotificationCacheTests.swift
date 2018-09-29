//
//  LocalNotificationCacheTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 9/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest

@testable import Freetime
@testable import GitHubAPI

class LocalNotificationCacheTests: XCTestCase {

    func path(for test: String) -> String {
        let clean = test.replacingOccurrences(of: "()", with: "")
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return "\(path)/\(clean).sqlite"
    }

    func clear(for test: String) {
        let path = self.path(for: test)
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch  {
            print("\(error.localizedDescription)\npath: \(path)")
        }
    }

    func test_whenNoNotifications_thatNothingReturned() {
        clear(for: #function)
        
        let cache = LocalNotificationsCache(path: path(for: #function))
        var executed = false
        cache.update(notifications: []) { results in
            executed = true
            XCTAssertEqual(results.count, 0)
        }
        XCTAssertTrue(executed)
    }

    func makeRepo() -> V3Repository {
        return V3Repository(
            description: nil,
            fork: false,
            fullName: "org/name",
            id: 42,
            name: "name",
            owner: V3User(
                avatarUrl: URL(string: "github.com")!,
                id: 1,
                login: "github",
                siteAdmin: false,
                type: .user
            ),
            isPrivate: false
        )
    }

    func makeNotificaction(id: String, title: String, updatedAt: Date = Date()) -> V3Notification {
        return V3Notification(
            id: id,
            lastReadAt: nil,
            reason: .assign,
            repository: makeRepo(),
            subject: V3NotificationSubject(title: title, type: .issue, url: nil),
            unread: true,
            updatedAt: updatedAt
        )
    }

    func test_whenUpdating_thatReadFirstTime_thenSecondCallEmpty() {
        clear(for: #function)
        
        let cache = LocalNotificationsCache(path: path(for: #function))
        let n1 = [
            makeNotificaction(id: "123", title: "foo")
        ]
        var executions = 0

        cache.update(notifications: n1) { results in
            executions += 1
            XCTAssertEqual(results.count, 1)
        }

        let n2 = [
            makeNotificaction(id: "123", title: "foo"),
            makeNotificaction(id: "456", title: "bar")
        ]
        cache.update(notifications: n2) { results in
            executions += 1
            XCTAssertEqual(results.count, 1)
        }

        let n3 = [
            makeNotificaction(id: "123", title: "foo"),
            makeNotificaction(id: "456", title: "bar")
        ]

        cache.update(notifications: n3) { results in
            executions += 1
            XCTAssertEqual(results.count, 0)
        }

        XCTAssertEqual(executions, 3)
    }
    
    func test_whenUpdatingWithSameNotificationWithUpdatedTime_thatNotificationReceived() {
        clear(for: #function)
        
        let cache = LocalNotificationsCache(path: path(for: #function))
        let n1 = [
            makeNotificaction(id: "123", title: "foo", updatedAt: Date())
        ]
        
        cache.update(notifications: n1) { results in
            XCTAssertEqual(results.count, 1)
        }
        
        cache.update(notifications: n1) { results in
            XCTAssertEqual(results.count, 0)
        }
        
        let n2 = [
            makeNotificaction(id: "123", title: "foo", updatedAt: Date(timeIntervalSinceNow: 10))
        ]
        
        cache.update(notifications: n2) { results in
            XCTAssertEqual(results.count, 1)
        }
    }

}
