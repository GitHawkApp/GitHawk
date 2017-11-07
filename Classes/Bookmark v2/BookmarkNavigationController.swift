//
//  BookmarkNavigationController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

// create and store on a VC when working w/ bookmarkable data
// must manually add to UINavigationItem
final class BookmarkNavigationController {

    private let store: BookmarkStore
    private let model: Bookmark

    init?(store: BookmarkStore?, model: Bookmark?) {
        guard let store = store, let model = model else { return nil }
        self.store = store
        self.model = model
    }

    // MARK: Public API

    var navigationItem: UIBarButtonItem {
        let accessibilityLabel: String
        let imageName: String
        let selector: Selector

        if store.contains(model) {
            imageName = "nav-bookmark-selected"
            accessibilityLabel = Constants.Strings.removeBookmark
            selector = #selector(BookmarkNavigationController.remove(sender:))
        } else {
            imageName = "nav-bookmark"
            accessibilityLabel = Constants.Strings.bookmark
            selector = #selector(BookmarkNavigationController.add(sender:))
        }

        let item = UIBarButtonItem(
            image: UIImage(named: imageName),
            style: .plain,
            target: self,
            action: selector
        )
        item.accessibilityLabel = accessibilityLabel
        return item
    }

    // MARK: Private API

    @objc func add(sender: UIBarButtonItem) {
        Haptic.triggerSelection()
        sender.action = #selector(BookmarkNavigationController.remove(sender:))
        sender.image = UIImage(named: "nav-bookmark-selected")
        store.add(model)
    }

    @objc func remove(sender: UIBarButtonItem) {
        sender.action = #selector(BookmarkNavigationController.add(sender:))
        sender.image = UIImage(named: "nav-bookmark")
        store.remove(model)
    }

}
