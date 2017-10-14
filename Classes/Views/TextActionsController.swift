//
//  TextActionsController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class TextActionsController: IssueTextActionsViewDelegate {

    private weak var textView: UITextView? = nil

    // MARK: Public API

    func configure(textView: UITextView, actions: IssueTextActionsView) {
        self.textView = textView
        actions.delegate = self
    }

    // MARK: IssueTextActionsViewDelegate

    func didSelect(actionsView: IssueTextActionsView, operation: IssueTextActionOperation) {
        switch operation.operation {
        case .execute(let block): block()
        case .wrap(let left, let right): textView?.replace(left: left, right: right, atLineStart: false)
        case .line(let left): textView?.replace(left: left, right: nil, atLineStart: true)
        }
    }

}
