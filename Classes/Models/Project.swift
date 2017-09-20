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
                /// Unique identifier for the card
                let id: String
                
                /// If the card is either an Issue or Pull Request this is the ID of that. Nil if type is Note.
                let contentId: Int?
                
                /// Title of Issue/PR or Note
                let title: String
                
                /// The actor who created this card
                let creator: Creator?
                
                init(id: String, title: String, creator: Creator?, contentId: Int?) {
                    self.id = id
                    self.title = title
                    self.creator = creator
                    self.contentId = contentId
                }
            }
            
            /// Title of the column
            let name: String
            
            /// Ordered list of cards
            let cards: [Card]
            
            init(name: String, cards: [Card]) {
                self.name = name
                self.cards = cards
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
        return title == object.title && contentId == object.contentId && creator?.login == object.creator?.login
    }
    
}
