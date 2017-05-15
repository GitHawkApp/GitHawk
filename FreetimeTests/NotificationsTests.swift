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
    
}
