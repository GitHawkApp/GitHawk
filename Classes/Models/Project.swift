//
//  Project.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

class Project {
    
    struct Details {
        class Column {
            /// Object defining either an Issue, Pull Request or Note within a project column
            class Card {
                enum CardType {
                    case note
                    case issue(IssueStatus, Int)
                    case pullRequest(IssueStatus, Int)
                    
                    var rawValue: String {
                        switch self {
                        case .note: return "note"
                        case .issue: return "issue"
                        case .pullRequest: return "pull-request"
                        }
                    }
                }
                
                /// Unique identifier for the card
                let id: String
                
                /// Type of card either note, issue or pull request. Contains ID/Status
                let type: CardType
                
                /// Title of Issue/PR or Note
                let title: NSAttributedStringSizing
                
                /// The actor who created this card
                let creator: Creator?
                
                init(id: String, title: String, creator: Creator?, type: CardType) {
                    self.id = id
                    self.creator = creator
                    self.type = type
                    
                    let attributed = NSAttributedString(string: title, attributes: ColumnCardCell.titleAttributes)
                    self.title = NSAttributedStringSizing(containerWidth: 0, attributedText: attributed, inset: ColumnCardCell.titleInset)
                }
            }
            
            /// Title of the column
            let name: String
            
            /// Ordered list of cards
            let cards: [Card]
            
            /// Total amount of cards in this column
            let totalCount: Int
            
            init(name: String, cards: [Card], totalCount: Int) {
                self.name = name
                self.cards = cards
                self.totalCount = totalCount
            }
        }
        
        /// Ordered list of columns
        let columns: [Column]
    }
    
    let number: Int
    let name: String
    let body: NSAttributedStringSizing?
    let repository: RepositoryDetails
    
    // Currently, only loaded once the user enters a project
    var details: Details?
    
    init(number: Int, name: String, body: String?, containerWidth: CGFloat, repo: RepositoryDetails) {
        self.number = number
        self.name = name
        self.repository = repo
        
        if let body = body {
            let attributedString = NSAttributedString(string: body, attributes: ProjectSummaryCell.descriptionAttributes)
            self.body = NSAttributedStringSizing(containerWidth: containerWidth, attributedText: attributedString, inset: ProjectSummaryCell.descriptionInset)
        } else {
            self.body = nil
        }
    }
    
    func loadDetails(client: GithubClient, completion: @escaping (Error?) -> Void) {
        client.load(project: self) { [weak self] response in
            switch response {
            case .error(let error):
                completion(error)
            case .success(let details):
                self?.details = details
                completion(nil)
            }
        }
    }
}

extension Project: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: number)
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? Project else { return false }
        return number == object.number && name == object.name && body == object.body
    }
    
}

extension Project.Details.Column: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return name as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? Project.Details.Column else { return false }
        // Don't need to compare cards as the nested collection view will deal with that
        return name == object.name
    }
    
}

extension Project.Details.Column.Card: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? Project.Details.Column.Card else { return false }
        return title == object.title && type.rawValue == object.type.rawValue && creator?.login == object.creator?.login
    }
    
}

extension Project.Details.Column.Card.CardType {
    
    var style: (image: UIImage?, color: UIColor) {
        switch self {
        case .note: return (UIImage(named: "note"), Styles.Colors.Gray.dark.color)
        case .issue(let status, _):
            switch status {
            case .open: return (UIImage(named: "issue-opened"), Styles.Colors.Green.medium.color)
            default: return (UIImage(named: "issue-closed"), Styles.Colors.Red.medium.color)
            }
        case .pullRequest(let status, _):
            switch status {
            case .merged: return (UIImage(named: "git-merge"), Styles.Colors.purple.color)
            case .closed: return (UIImage(named: "git-pull-request"), Styles.Colors.Red.medium.color)
            case .open: return (UIImage(named: "git-pull-request"), Styles.Colors.Green.medium.color)
            }
        }
    }
    
}
