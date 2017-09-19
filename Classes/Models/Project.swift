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
        struct Column {
            /// Object defining either an Issue, Repository or Note within a project column
            struct Card {
                let temp: String
            }
            
            let name: String
            let cards: [Card]
        }
        
        let columns: [Column]
    }
    
    let number: Int
    let name: String
    let body: NSAttributedStringSizing?
    
    // Currently, only loaded once the user enters a project
    var details: Details?
    
    init(number: Int, name: String, body: String?, containerWidth: CGFloat) {
        // TODO: Make name/body sizable strings for lists
        self.number = number
        self.name = name
        
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
        return number == number && name == object.name && body == object.body
    }
    
}
