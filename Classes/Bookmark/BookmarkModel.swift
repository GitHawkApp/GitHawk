//
//  BookmarkModel.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class BookmarkModel: NSObject, NSCoding, Filterable {

    private enum Keys: String {
        case owner
        case number
        case name
        case type
        case title
        case hasIssueEnabled
    }

    let type: NotificationType
    let name: String
    let owner: String
    let number: Int
    let title: String
    let hasIssueEnabled: Bool
    let defaultBranch: String

    init(
        type: NotificationType,
        name: String,
        owner: String,
        number: Int = 0,
        title: String = "",
        hasIssueEnabled: Bool = false,
        defaultBranch: String = "master"
    ) {
        self.type = type
        self.name = name
        self.owner = owner
        self.number = number
        self.title = title
        self.hasIssueEnabled = hasIssueEnabled
        self.defaultBranch = defaultBranch
    }

    convenience required init?(coder aDecoder: NSCoder) {
        guard let owner = aDecoder.decodeObject(forKey: Keys.owner.rawValue) as? String else { return nil }
        guard let name = aDecoder.decodeObject(forKey: Keys.name.rawValue) as? String else { return nil }
        guard let type = aDecoder.decodeObject(forKey: Keys.type.rawValue) as? String else { return nil }
        guard let title = aDecoder.decodeObject(forKey: Keys.title.rawValue) as? String else { return nil }
        let hasIssueEnabled = aDecoder.decodeBool(forKey: Keys.hasIssueEnabled.rawValue)
        let number = aDecoder.decodeInteger(forKey: Keys.number.rawValue) as Int

        self.init(
            type: NotificationType(rawValue: type)!,
            name: name,
            owner: owner,
            number: number,
            title: title,
            hasIssueEnabled: hasIssueEnabled
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(owner, forKey: Keys.owner.rawValue)
        aCoder.encode(number, forKey: Keys.number.rawValue)
        aCoder.encode(name, forKey: Keys.name.rawValue)
        aCoder.encode(type.rawValue, forKey: Keys.type.rawValue)
        aCoder.encode(title, forKey: Keys.title.rawValue)
        aCoder.encode(hasIssueEnabled, forKey: Keys.hasIssueEnabled.rawValue)
    }

    override var hashValue: Int {
        return "\(name)\(owner)\(number)".hashValue
    }

    override func isEqual(_ object: Any?) -> Bool {
        let bookmark = (object as? BookmarkModel)
        return hashValue == bookmark?.hashValue
    }

    // MARK: Filterable

    func match(query: String) -> Bool {
        let lowerQuery = query.lowercased()

        if type.rawValue.contains(lowerQuery) { return true }
        if String(number).contains(lowerQuery) { return true }
        if title.lowercased().contains(lowerQuery) { return true }
        if owner.lowercased().contains(lowerQuery) { return true }
        if name.lowercased().contains(lowerQuery) { return true }

        return false
    }
}
