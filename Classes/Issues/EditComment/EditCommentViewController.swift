//
//  EditCommentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol EditCommentViewControllerDelegate: class {

}

class EditCommentViewController: UIViewController {

    weak var delegate: EditCommentViewControllerDelegate? = nil

    private let textView = UITextView()
    private let textActionsController = TextActionsController()
    private let repo: String
    private let owner: String

    init(markdown: String, owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
        textView.text = markdown
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.githawkConfigure(inset: true)
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        setupInputView()

        title = NSLocalizedString("Edit Comment", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(EditCommentViewController.onCancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Save", comment: ""),
            style: .done,
            target: self,
            action: #selector(EditCommentViewController.onSave)
        )

        let nc = NotificationCenter.default
        nc.addObserver(
            self,
            selector: #selector(EditCommentViewController.onKeyboardWillShow(notification:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        nc.addObserver(
            self,
            selector: #selector(EditCommentViewController.onKeyboardWillHide(notification:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    // MARK: Private API

    func setupInputView() {
        let getMarkdownBlock = { [weak self] () -> (String) in
            return self?.textView.text ?? ""
        }
        let actions = IssueTextActionsView.forMarkdown(
            viewController: self,
            getMarkdownBlock: getMarkdownBlock,
            repo: repo,
            owner: owner,
            addBorder: true
        )
        textActionsController.configure(textView: textView, actions: actions)
    }

    @objc
    func onCancel() {
        cancelAction_onCancel(
            texts: [textView.text],
            title: NSLocalizedString("Unsaved Changes", comment: ""),
            message: NSLocalizedString("Are you sure you want to discard your edit? Your changes will be lost.",
                                       comment: "")
        )
    }

    @objc
    func onSave() {
        print("save")
    }

    // MARK: Notifications

    @objc
    func onKeyboardWillShow(notification: NSNotification) {
        print("kb will show")
    }

    @objc
    func onKeyboardWillHide(notification: NSNotification) {
        print("kb will show")
    }

}
