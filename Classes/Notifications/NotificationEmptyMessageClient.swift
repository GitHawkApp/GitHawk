//
//  NotificationEmptyMessageClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Firebase

final class NotificationEmptyMessageClient {

    struct Message {
        let emoji: String
        let text: String
    }

    private lazy var reference: DatabaseReference = {
        let r = Database.database().reference()
        r.keepSynced(true)
        return r
    }()

    // MARK: Public API

    func fetch(completion: @escaping (Result<Message>) -> Void) {
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let inboxZero = (snapshot.value as? [String: Any])?["inbox_zero"] as? [String: Any],
                let emoji = inboxZero["emoji"] as? String,
                let text = inboxZero["text"] as? String {
                completion(.success(Message(emoji: emoji, text: text)))
            } else {
                completion(.error(nil))
            }
        }) { (error) in
            completion(.error(error))
        }
    }

}
