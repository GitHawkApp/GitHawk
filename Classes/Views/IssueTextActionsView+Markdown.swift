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
        addBorder: Bool
        ) -> IssueTextActionsView {
        let operations: [IssueTextActionOperation] = [
            IssueTextActionOperation(icon: UIImage(named: "bar-eye"), operation: .execute({ [weak viewController] in
                let controller = IssuePreviewViewController(markdown: getMarkdownBlock(), owner: owner, repo: repo)
                viewController?.navigationController?.pushViewController(controller, animated: true)
            })),
            IssueTextActionOperation(icon: UIImage(named: "bar-bold"), operation: .wrap("**", "**")),
            IssueTextActionOperation(icon: UIImage(named: "bar-italic"), operation: .wrap("_", "_")),
            IssueTextActionOperation(icon: UIImage(named: "bar-code"), operation: .wrap("`", "`")),
            IssueTextActionOperation(icon: UIImage(named: "bar-code-block"), operation: .wrap("```\n", "\n```")),
            IssueTextActionOperation(icon: UIImage(named: "bar-strikethrough"), operation: .wrap("~~", "~~")),
            IssueTextActionOperation(icon: UIImage(named: "bar-header"), operation: .line("#")),
            IssueTextActionOperation(icon: UIImage(named: "bar-ul"), operation: .line("- ")),
            IssueTextActionOperation(icon: UIImage(named: "bar-indent"), operation: .line("  ")),
            IssueTextActionOperation(icon: UIImage(named: "bar-link"), operation: .wrap("[", "](\(UITextView.cursorToken))")),
            IssueTextActionOperation(icon: UIImage(named: "cloud-upload"), operation: .execute({ [weak viewController] in
                guard let strongVc = viewController else { return }
                
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = strongVc as? (UINavigationControllerDelegate & UIImagePickerControllerDelegate)
                imagePicker.modalPresentationStyle = .popover
                imagePicker.popoverPresentationController?.canOverlapSourceViewRect = true
                
                let sourceFrame = viewController?.view.frame ?? .zero
                let sourceRect = CGRect(origin: CGPoint(x: sourceFrame.midX, y: sourceFrame.minY), size: CGSize(width: 1, height: 1))
                imagePicker.popoverPresentationController?.sourceView = viewController?.view
                imagePicker.popoverPresentationController?.sourceRect = sourceRect
                imagePicker.popoverPresentationController?.permittedArrowDirections = .up
                
                strongVc.present(imagePicker, animated: true, completion: nil)
            }))
        ]
        
        let actions = IssueTextActionsView(operations: operations)
        actions.backgroundColor = Styles.Colors.Gray.lighter.color
        if addBorder {
            actions.addBorder(.top)
            actions.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        }
        return actions
    }

}

