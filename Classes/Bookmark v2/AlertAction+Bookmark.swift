//
//  AlertAction+Bookmark.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension AlertAction {

    static func toggleBookmark(
        store: BookmarkStore,
        model: Bookmark
        ) -> UIAlertAction {
        let isNewBookmark = !store.contains(model)
        let title = isNewBookmark ? Constants.Strings.bookmark : Constants.Strings.removeBookmark
        return UIAlertAction(title: title, style: isNewBookmark ? .default : .destructive, handler: { _ in
            if isNewBookmark {
                store.add(model)
            } else {
                store.remove(model)
            }
            Haptic.triggerNotification(.success)
        })
    }

}
