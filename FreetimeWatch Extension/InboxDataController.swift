//
//  InboxDataController.swift
//  FreetimeWatch Extension
//
//  Created by Ryan Nystrom on 4/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI

protocol InboxDataControllerDelegate: class {
    func didUpdate(dataController: InboxDataController)
}

final class InboxDataController {

    weak var delegate: InboxDataControllerDelegate?

    typealias NotificationGroup = (repo: V3Repository, notifications: [V3Notification])

    private var readRepos = Set<V3Repository>()
    private var _groupedNotifications = [NotificationGroup]()

    var unreadNotifications: [NotificationGroup] {
        return _groupedNotifications.filter { !readRepos.contains($0.repo) }
    }

    func read(repository: V3Repository) {
        readRepos.insert(repository)
        delegate?.didUpdate(dataController: self)
    }

    func unread(repository: V3Repository) {
        readRepos.remove(repository)
        delegate?.didUpdate(dataController: self)
    }

    func readAll() {
        _groupedNotifications.forEach { readRepos.insert($0.repo) }
        delegate?.didUpdate(dataController: self)
    }

    func unreadAll() {
        _groupedNotifications.forEach { readRepos.remove($0.repo) }
        delegate?.didUpdate(dataController: self)
    }

    func supply(notifications: [V3Notification]) {
        var map = [V3Repository: [V3Notification]]()
        for n in notifications {
            var arr = map[n.repository] ?? []
            arr.append(n)
            map[n.repository] = arr
        }

        _groupedNotifications.removeAll()
        let repos = map.keys.sorted { $0.name.lowercased() < $1.name.lowercased() }
        for r in repos {
            guard let notes = map[r] else { continue }
            _groupedNotifications.append((r, notes))
        }

        delegate?.didUpdate(dataController: self)
    }
    
}
