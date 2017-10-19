//
//  BookmarkModel.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

class BookmarkModel: NSObject, NSCoding {
    
    struct Keys {
        static let owner = "owner"
        static let number = "number"
        static let name = "name"
        static let type = "type"
        static let title = "title"
        static let hasIssueEnabled = "hasIssueEnabled"
    }
    
    enum BookmarkType: String {
        case repo = "repo"
        case issue = "issue"
        case pullRequest = "pullRequest"
    }
    
    let type: BookmarkType
    let name: String
    let owner: String
    let number: Int
    let title: String
    let hasIssueEnabled: Bool
    
    init(
        type: BookmarkType,
        name: String,
        owner: String,
        number: Int = 0,
        title: String = "",
        hasIssueEnabled: Bool = false
    ) {
        self.type = type
        self.name = name
        self.owner = owner
        self.number = number
        self.title = title
        self.hasIssueEnabled = hasIssueEnabled
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        guard let owner = aDecoder.decodeObject(forKey: Keys.owner) as? String else { return nil }
        guard let name = aDecoder.decodeObject(forKey: Keys.name) as? String else { return nil }
        guard let type = aDecoder.decodeObject(forKey: Keys.type) as? String else { return nil }
        guard let title = aDecoder.decodeObject(forKey: Keys.title) as? String else { return nil }
        let hasIssueEnabled = aDecoder.decodeBool(forKey: Keys.hasIssueEnabled)
        let number = aDecoder.decodeInteger(forKey: Keys.number) as Int
        
        self.init(
            type: BookmarkType(rawValue: type)!,
            name: name,
            owner: owner,
            number: number,
            title: title,
            hasIssueEnabled: hasIssueEnabled
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(owner, forKey: Keys.owner)
        aCoder.encode(number, forKey: Keys.number)
        aCoder.encode(name, forKey: Keys.name)
        aCoder.encode(type.rawValue, forKey: Keys.type)
        aCoder.encode(title, forKey: Keys.title)
        aCoder.encode(hasIssueEnabled, forKey: Keys.hasIssueEnabled)
    }
    
    override var hashValue: Int {
        get {
            return (name + owner + "\(number)").hashValue
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        let bookmark = (object as? BookmarkModel)
        return hashValue == bookmark?.hashValue
    }
}
