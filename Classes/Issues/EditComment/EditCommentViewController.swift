//
//  EditCommentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import MessageViewController
import GitHubAPI

protocol EditCommentViewControllerDelegate: class {
    func didEditComment(viewController: EditCommentViewController, markdown: String)
    func didCancel(viewController: EditCommentViewController)
}

final class EditCommentViewController: UIViewController,
MessageTextViewListener {

    weak var delegate: EditCommentViewControllerDelegate?

    private let commentID: Int
    private let client: GithubClient
    private let textView = MessageTextView()
    private let textActionsController = TextActionsController()
    private let issueModel: IssueDetailsModel
    private let isRoot: Bool
    private let isInPullRequestReview: Bool
    private let originalMarkdown: String
    private var keyboardAdjuster: ScrollViewKeyboardAdjuster?
    private let autocompleteController: AutocompleteController

    init(
        client: GithubClient,
        markdown: String,
        issueModel: IssueDetailsModel,
        commentID: Int,
        isRoot: Bool,
        isInPullRequestReview: Bool,
        autocomplete: IssueCommentAutocomplete
        ) {
        self.client = client
        self.issueModel = issueModel
        self.commentID = commentID
        self.isRoot = isRoot
        self.isInPullRequestReview = isInPullRequestReview
        self.originalMarkdown = markdown
        self.autocompleteController = AutocompleteController(
            messageAutocompleteController: MessageAutocompleteController(textView: textView),
            autocomplete: autocomplete
        )

        super.init(nibName: nil, bundle: nil)

        textView.text = markdown
        textView.add(listener: self)
        autocompleteController.messageAutocompleteController.layoutDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardAdjuster = ScrollViewKeyboardAdjuster(
            scrollView: textView,
            viewController: self
        )

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
        setRightBarItemIdle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    // MARK: Accessibility

    override func accessibilityPerformMagicTap() -> Bool {
        guard !textView.text.isEmpty else { return false }
        onSave()
        return true
    }

    // MARK: Private API

    func setRightBarItemIdle() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Save", comment: ""),
            style: .done,
            target: self,
            action: #selector(EditCommentViewController.onSave)
        )
    }

    func setupInputView() {
        let getMarkdownBlock = { [weak self] () -> (String) in
            return self?.textView.text ?? ""
        }
        let actions = IssueTextActionsView.forMarkdown(
            viewController: self,
            getMarkdownBlock: getMarkdownBlock,
            repo: issueModel.repo,
            owner: issueModel.repo,
            addBorder: true,
            supportsImageUpload: true
        )
        
        textActionsController.configure(client: client, textView: textView, actions: actions)
        textActionsController.viewController = self
        
        textView.inputAccessoryView = actions
    }

    @objc func onCancel() {
        textView.resignFirstResponder()

        let dismissBlock = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didCancel(viewController: strongSelf)
        }

        // if text unchanged, just dismiss
        if originalMarkdown == textView.text {
            dismissBlock()
        } else {
            let alert = UIAlertController(
                title: NSLocalizedString("Unsaved Changes", comment: ""),
                message: NSLocalizedString("Are you sure you want to discard your edit? Your changes will be lost.", comment: ""),
                preferredStyle: .alert
            )
            alert.addActions([
                AlertAction.goBack(),
                AlertAction.discard { _ in
                    dismissBlock()
                }
                ])
            present(alert, animated: trueUnlessReduceMotionEnabled)
        }
    }

    @objc func onSave() {
        setRightBarItemSpinning()
        textView.isEditable = false
        textView.resignFirstResponder()
        let markdown = textView.text ?? ""

        client.client.send(V3EditCommentRequest(
            owner: issueModel.owner,
            repo: issueModel.repo,
            issueNumber: issueModel.number,
            commentID: commentID,
            body: markdown,
            isRoot: isRoot,
            isInPullRequestReview: isInPullRequestReview)
        ) { [weak self] result in
            switch result {
            case .success: self?.didSave(markdown: markdown)
            case .failure: self?.error()
            }
        }
    }

    func didSave(markdown: String) {
        navigationItem.rightBarButtonItem = nil
        delegate?.didEditComment(viewController: self, markdown: markdown)
    }

    func error() {
        setRightBarItemIdle()
        ToastManager.showGenericError()
    }

    // MARK: MessageTextViewListener

    func didChange(textView: MessageTextView) {
        navigationItem.rightBarButtonItem?.isEnabled = !textView.text.isEmpty
    }

    func willChangeRange(textView: MessageTextView, to range: NSRange) {}
    func didChangeSelection(textView: MessageTextView) {}

}
