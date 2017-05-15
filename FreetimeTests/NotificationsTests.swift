//
//  NotificationsTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class NotificationsTests: ListKitTestCase {

    override func setUp() {
        super.setUp()
        kit.sectionControllerBlock = { _ in
            return RepoNotificationsSectionController()
        }
    }

    func test_withOneNotification() {
        let notification = NotificationViewModel(
            title: "Notification 1 title",
            type: .issue,
            date: Date(),
            read: false,
            containerWidth: 320
        )
        let repo = RepoNotifications(repoName: "Repo Name", notifications: [notification])

        kit.objects = [repo]

        let expect = expectation(description: #function)
        kit.adapter.performUpdates(animated: false) { _ in
            expect.fulfill()

            XCTAssertEqual(self.kit.collectionView.numberOfSections, 1)
            XCTAssertEqual(self.kit.collectionView.numberOfItems(inSection: 0), 2)

            let titleCell = self.kit.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! NotificationRepoCell
            XCTAssertEqual(titleCell.label.text, "Repo Name")

            let notificationCell = self.kit.collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as! NotificationCell
            XCTAssertEqual(notificationCell.titleLabel.text, "Notification 1 title")
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func test_whenFilteringNotifications() {
        let repos = [
            RepoNotifications(repoName: "Repo 1", notifications: [
                NotificationViewModel(
                    title: "Notification 1-1",
                    type: .issue,
                    date: Date(timeIntervalSinceNow: -1),
                    read: true,
                    containerWidth: 320
                ),
                NotificationViewModel(
                    title: "Notification 1-2",
                    type: .issue,
                    date: Date(timeIntervalSinceNow: -2),
                    read: false,
                    containerWidth: 320
                ),
                NotificationViewModel(
                    title: "Notification 1-3",
                    type: .issue,
                    date: Date(timeIntervalSinceNow: -3),
                    read: true,
                    containerWidth: 320
                ),
                ]),
            RepoNotifications(repoName: "Repo 2", notifications: [
                NotificationViewModel(
                    title: "Notification 2-1",
                    type: .issue,
                    date: Date(timeIntervalSinceNow: -1),
                    read: true,
                    containerWidth: 320
                ),
                NotificationViewModel(
                    title: "Notification 2-2",
                    type: .issue,
                    date: Date(timeIntervalSinceNow: -2),
                    read: true,
                    containerWidth: 320
                ),
                ])
        ]

        let all = filter(repoNotifications: repos, unread: false)
        XCTAssertEqual(all.count, 2)
        XCTAssertEqual(all[0].notifications.count, 3)
        XCTAssertEqual(all[1].notifications.count, 2)

        let unread = filter(repoNotifications: repos, unread: true)
        XCTAssertEqual(unread.count, 1)
        XCTAssertEqual(unread[0].notifications.count, 1)
    }
    
}
