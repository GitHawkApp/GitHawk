//
//  MessageViewDelegate.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

internal protocol MessageViewDelegate: class {
    func sizeDidChange(messageView: MessageView)
    func wantsLayout(messageView: MessageView)
    func selectionDidChange(messageView: MessageView)
}
