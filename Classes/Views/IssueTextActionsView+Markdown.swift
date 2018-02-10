//
//  IssueTextActionsView+Markdown.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension IssueTextActionsView {

    static func forMarkdown(
        viewController: UIViewController,
        getMarkdownBlock: @escaping () -> (String),
        repo: String,
        owner: String,
        addBorder: Bool,
        supportsImageUpload: Bool
        ) -> IssueTextActionsView {
        var operations: [IssueTextActionOperation] = [
            IssueTextActionOperation(
                icon: UIImage(named: "bar-eye"),
                operation: .execute({ [weak viewController] in
                let controller = IssuePreviewViewController(markdown: getMarkdownBlock(), owner: owner, repo: repo)
                viewController?.navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
            }),
                name: NSLocalizedString("Message Preview", comment: "The name of the action for previewing a message from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "mention"),
                operation: .line("@"),
                name: NSLocalizedString("Add mention to text", comment: "The name of the action for making text a mention from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-bold"),
                operation: .wrap("**", "**"),
                name: NSLocalizedString("Make text bold", comment: "The name of the action for making text bold from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-italic"),
                operation: .wrap("_", "_"),
                name: NSLocalizedString("Make text italic", comment: "The name of the action for making text italic from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-code"),
                operation: .wrap("`", "`"),
                name: NSLocalizedString("Make text monospaced", comment: "The name of the action for making text monospaced / appear as code from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-code-block"),
                operation: .wrap("```\n", "\n```"),
                name: NSLocalizedString("Make text appear as code", comment: "The name of the action for making text appear as code from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-strikethrough"),
                operation: .wrap("~~", "~~"),
                name: NSLocalizedString("Strikethrough text", comment: "The name of the action for making text strikethrough from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-header"),
                operation: .line("#"),
                name: NSLocalizedString("Add header to text", comment: "The name of the action for making text a header from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-ul"),
                operation: .line("- "),
                name: NSLocalizedString("Make text a list item", comment: "The name of the action for making text a list item from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-indent"),
                operation: .line("  "),
                name: NSLocalizedString("Make text indented", comment: "The name of the action for making text indented from the markdown actions bar")),
            IssueTextActionOperation(
                icon: UIImage(named: "bar-link"),
                operation: .wrap("[", "](\(UITextView.cursorToken))"),
                name: NSLocalizedString("Wrap text as URL", comment: "The name of the action to wrap text in a markdown URL from the markdown actions bar"))
        ]

        if supportsImageUpload {
            operations.append(IssueTextActionOperation(
                icon: UIImage(named: "bar-upload"),
                operation: .uploadImage,
                name: NSLocalizedString("Upload Image", comment: "The name of the action to upload an image from the markdown actions bar")))
        }

        let actions = IssueTextActionsView(operations: operations)
        actions.backgroundColor = Styles.Colors.Gray.lighter.color
        if addBorder {
            actions.addBorder(.top)
            actions.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        }
        return actions
    }

}
