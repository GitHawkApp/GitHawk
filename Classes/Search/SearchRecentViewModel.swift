//
//  SearchRecentViewModel.swift
//  Freetime
//
//  Created by Hesham Salman on 10/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

private enum Keys {
    static let search = "search"
    static let viewed = "viewed"
}

final class SearchRecentViewModel: NSObject, ListDiffable {

    let query: SearchQuery

    init(query: SearchQuery) {
        self.query = query
    }

    var displayText: NSAttributedString {
        switch query {
        case .search(let text):
            return NSAttributedString(string: text, attributes: standardAttributes)
        case .recentlyViewed(let repoDetails):
            let text = NSMutableAttributedString(string: repoDetails.owner + "/", attributes: standardAttributes)
            text.append(NSAttributedString(string: repoDetails.name, attributes: boldAttributes))
            return text
        }
    }

    var icon: UIImage {
        switch query {
        case .search:
            return #imageLiteral(resourceName: "search")
        case .recentlyViewed:
            return #imageLiteral(resourceName: "repo")
        }
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        var identifier: String
        switch query {
        case .recentlyViewed:
            identifier = Keys.viewed
        case .search:
            identifier = Keys.search
        }
        return (identifier + displayText.string) as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SearchRecentViewModel else {
            return false
        }
        return displayText == object.displayText
    }

    // MARK: Private API

    private var standardAttributes: [NSAttributedStringKey: Any] {
        return [
            .font: Styles.Fonts.body,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]
    }

    private var boldAttributes: [NSAttributedStringKey: Any] {
        return [
            .font: Styles.Fonts.bodyBold,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]
    }
}
