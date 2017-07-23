//
//  IssueCommentAutocomplete.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol IssueCommentAutocompleteDelegate: class {
    func didFinish(autocomplete: IssueCommentAutocomplete, hasResults: Bool)
}

final class IssueCommentAutocomplete {

    let cellHeight = Styles.Sizes.labelEventHeight

    private weak var delegate: IssueCommentAutocompleteDelegate? = nil
    private let identifier = "identifier"
    private let emojiAutocomplete = EmojiAutocomplete()
    private var emoji = [EmojiResult]()

    enum Prefix: String {
        case emoji = ":"
    }

    // MARK: Public APIs

    var prefixes: [String] {
        return [
            Prefix.emoji.rawValue
        ]
    }

    func configure(tableView: UITableView, delegate: IssueCommentAutocompleteDelegate) {
        self.delegate = delegate
        tableView.register(AutocompleteCell.self, forCellReuseIdentifier: identifier)
    }

    func resultCount(prefix: String?) -> Int {
        guard let prefix = prefix, let type = Prefix(rawValue: prefix) else { return 0 }
        switch type {
        case .emoji:
            return emoji.count
        }
    }

    func resultHeight(prefix: String?) -> CGFloat {
        return CGFloat(resultCount(prefix: prefix)) * cellHeight
    }

    func didChange(tableView: UITableView, prefix: String?, word: String) {
        guard let prefix = prefix, let type = Prefix(rawValue: prefix) else {
            delegate?.didFinish(autocomplete: self, hasResults: false)
            return
        }

        switch type {
        case .emoji:
            emoji = emojiAutocomplete.search(word)
            delegate?.didFinish(autocomplete: self, hasResults: emoji.count > 0)
        }
    }

    func cell(tableView: UITableView, prefix: String?, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = cell as? AutocompleteCell,
            let prefix = prefix,
            let type = Prefix(rawValue: prefix) {
            switch type {
            case .emoji:
                let result = emoji[indexPath.item]
                cell.configure(state: .emoji(emoji: result.emoji, term: result.term))
            }
        }

        return cell
    }

    func accept(prefix: String?, indexPath: IndexPath) -> String? {
        guard let prefix = prefix, let type = Prefix(rawValue: prefix) else {
            return nil
        }
        switch type {
        case .emoji:
            return emoji[indexPath.item].emoji
        }
    }

}
