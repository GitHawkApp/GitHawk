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

protocol EditCommentViewControllerDelegate: class {
    func didEditComment(viewController: EditCommentViewController, markdown: String)
    func didCancel(viewController: EditCommentViewController)
}

final class EditCommentViewController: UIViewController,
    MessageTextViewListener,
    MessageAutocompleteControllerDelegate,
    MessageAutocompleteControllerLayoutDelegate,
    IssueCommentAutocompleteDelegate,
    UITableViewDataSource,
UITableViewDelegate {

    weak var delegate: EditCommentViewControllerDelegate?

    private let commentID: Int
    private let client: GithubClient
    private let textView = MessageTextView()
    private let textActionsController = TextActionsController()
    private let issueModel: IssueDetailsModel
    private let isRoot: Bool
    private let originalMarkdown: String
    private var keyboardAdjuster: ScrollViewKeyboardAdjuster?
    private let autocomplete: IssueCommentAutocomplete
    private let autocompleteController: MessageAutocompleteController

    init(
        client: GithubClient,
        markdown: String,
        issueModel: IssueDetailsModel,
        commentID: Int,
        isRoot: Bool,
        autocomplete: IssueCommentAutocomplete
        ) {
        self.client = client
        self.issueModel = issueModel
        self.commentID = commentID
        self.isRoot = isRoot
        self.originalMarkdown = markdown
        self.autocomplete = autocomplete
        self.autocompleteController = MessageAutocompleteController(textView: textView)
        super.init(nibName: nil, bundle: nil)
        textView.text = markdown
        textView.add(listener: self)

        autocomplete.configure(tableView: autocompleteController.tableView, delegate: self)
        autocompleteController.layoutDelegate = self
        autocompleteController.delegate = self
        autocompleteController.tableView.dataSource = self
        autocompleteController.tableView.delegate = self
        for prefix in autocomplete.prefixes {
            autocompleteController.register(prefix: prefix)
        }
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
        client.editComment(
            owner: issueModel.owner,
            repo: issueModel.repo,
            issueNumber: issueModel.number,
            commentID: commentID,
            body: markdown,
            isRoot: isRoot
        ) { [weak self] (result) in
            switch result {
            case .success: self?.didSave(markdown: markdown)
            case .error: self?.error()
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

    func didChangeSelection(textView: MessageTextView) {}

    // MARK: MessageAutocompleteControllerDelegate

    func didFind(controller: MessageAutocompleteController, prefix: String, word: String) {
        autocomplete.didChange(tableView: controller.tableView, prefix: prefix, word: word)
    }

    // MARK: MessageAutocompleteControllerLayoutDelegate

    func needsLayout(controller: MessageAutocompleteController) {
        controller.layout(in: view)
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocomplete.resultCount(prefix: autocompleteController.selection?.prefix)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return autocomplete.cell(
            tableView: tableView,
            prefix: autocompleteController.selection?.prefix,
            indexPath: indexPath
        )
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let accepted = autocomplete.accept(prefix: autocompleteController.selection?.prefix, indexPath: indexPath) {
            autocompleteController.accept(autocomplete: accepted + " ", keepPrefix: false)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autocomplete.cellHeight
    }

    // MARK: IssueCommentAutocompleteDelegate

    func didChangeStore(autocomplete: IssueCommentAutocomplete) {
        // edit doesn't add any stores
    }

    func didFinish(autocomplete: IssueCommentAutocomplete, hasResults: Bool) {
        autocompleteController.show(hasResults)
    }

}
