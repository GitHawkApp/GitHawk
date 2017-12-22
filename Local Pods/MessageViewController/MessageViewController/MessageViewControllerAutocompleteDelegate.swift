//
//  MessageViewControllerAutocompleteDelegate.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public protocol MessageViewControllerAutocompleteDelegate: class {
    func shouldHandleFindPrefix(prefix: String, word: String) -> Bool
}
