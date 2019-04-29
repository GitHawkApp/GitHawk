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

    private let store: BookmarkIDCloudStore
    private let graphQLID: String
    private static let iconImageInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)

    init?(store: BookmarkIDCloudStore?, graphQLID: String?) {
        guard let store = store, let graphQLID = graphQLID else { return nil }
        self.store = store
        self.graphQLID = graphQLID
    }

    // MARK: Public API

    var navigationItem: UIBarButtonItem {
        let item = UIBarButtonItem()
        configureNavigationItem(item)
        return item
    }

    func configureNavigationItem(_ item: UIBarButtonItem) {

        let accessibilityLabel: String
        let imageName: String
        let selector: Selector

        if store.contains(graphQLID: graphQLID) {
            imageName = "nav-bookmark-selected"
            accessibilityLabel = Constants.Strings.removeBookmark
            selector = #selector(BookmarkNavigationController.remove(sender:))
        } else {
            imageName = "nav-bookmark"
            accessibilityLabel = Constants.Strings.bookmark
            selector = #selector(BookmarkNavigationController.add(sender:))
        }

        item.accessibilityLabel = accessibilityLabel
        item.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        item.target = self
        item.action = selector
        item.isEnabled = true
        item.width = 0
        item.imageInsets = BookmarkNavigationController.iconImageInset
    }

    //for timeframe between viewDidLoad() and bookmark info is loaded 
    static var disabledNavigationItem: UIBarButtonItem {
        let item = UIBarButtonItem()
        item.image = UIImage(named: "nav-bookmark").withRenderingMode(.alwaysTemplate)
        item.isEnabled = false
        item.imageInsets = BookmarkNavigationController.iconImageInset
        return item
    }

    // MARK: Private API

    @objc func add(sender: UIBarButtonItem) {
        Haptic.triggerSelection()
        sender.action = #selector(BookmarkNavigationController.remove(sender:))
        sender.image = UIImage(named: "nav-bookmark-selected").withRenderingMode(.alwaysTemplate)
        store.add(graphQLID: graphQLID)
    }

    @objc func remove(sender: UIBarButtonItem) {
        sender.action = #selector(BookmarkNavigationController.add(sender:))
        sender.image = UIImage(named: "nav-bookmark").withRenderingMode(.alwaysTemplate)
        store.remove(graphQLID: graphQLID)
    }

}
