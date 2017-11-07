//
//  BookmarkAction.swift
//  Freetime
//
//  Created by Rizwan on 07/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct BookmarkAction {

    static func toggleBookmark(
        store: BookmarkStore,
        model: Bookmark,
        sender: UIBarButtonItem
        ) {
        if !store.contains(model) {
            store.add(model)
            sender.image = UIImage(named: "nav-bookmark-selected")
        } else {
            store.remove(model)
            sender.image = UIImage(named: "nav-bookmark")
        }
        Haptic.triggerNotification(.success)
    }
    
}
