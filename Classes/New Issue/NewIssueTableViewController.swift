//
//  NewIssueTableViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 22/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

enum IssueSignatureType {
    case bugReport
    case sentWithGitHawk

    var addition: String {
        switch self {
        case .bugReport:
            #if TESTFLIGHT
                let testFlight = "true"
            #else
                let testFlight = "false"
            #endif

            return [
                "\n",
                "<details>",
                "<summary>Bug Report Dump (Auto-generated)</summary>",
                "<pre>",
                Bundle.main.prettyVersionString,
                "Device: \(UIDevice.current.modelName) (iOS \(UIDevice.current.systemVersion))",
                "TestFlight: \(testFlight)",
                "</pre>",
                "</details>"
                ].joined(separator: "\n")
        case .sentWithGitHawk:
            return Signature.signed(text: "")
        }
    }
}

protocol NewIssueTableViewControllerDelegate: class {
    func didDismissAfterCreatingIssue(model: IssueDetailsModel)
}

final class NewIssueTableViewController: UITableViewController, UITextFieldDelegate {

    weak var delegate: NewIssueTableViewControllerDelegate?

    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextView!

    private var client: GithubClient!
    private var owner: String!
    private var repo: String!
    private var signature: IssueSignatureType?
    private let textActionsController = TextActionsController()

    private var titleText: String? {
        guard let raw = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
        if raw.isEmpty { return nil }
        return raw
    }

    private var bodyText: String? {
        let raw = bodyField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if raw.isEmpty { return nil }
        return raw
    }

    static func create(client: GithubClient,
                       owner: String,
                       repo: String,
                       signature: IssueSignatureType? = nil) -> NewIssueTableViewController? {
        let storyboard = UIStoryboard(name: "NewIssue", bundle: nil)

        let viewController = storyboard.instantiateInitialViewController() as? NewIssueTableViewController
        viewController?.hidesBottomBarWhenPushed = true
        viewController?.client = client
        viewController?.owner = owner
        viewController?.repo = repo
        viewController?.signature = signature

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add send button
        setRightBarItemIdle()

        // Add cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: Constants.Strings.cancel,
            style: .plain,
            target: self,
            action: #selector(onCancel)
        )

        // Make the return button move on to description field
        titleField.delegate = self

        // Setup markdown input view
        bodyField.githawkConfigure(inset: false)
        setupInputView()

        // Update title to use localization
        title = Constants.Strings.newIssue
    }

    // MARK: Private API

    func setRightBarItemIdle() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Submit", comment: ""),
            style: .done,
            target: self,
            action: #selector(onSend)
        )
        navigationItem.rightBarButtonItem?.isEnabled = titleText != nil
    }

    /// Attempts to sends the current forms information to GitHub, on success will redirect the user to the new issue
    @objc
    func onSend() {
        guard let titleText = titleText else {
            ToastManager.showError(message: NSLocalizedString("You must provide a title!", comment: "Invalid title when sending new issue"))
            return
        }

        titleField.resignFirstResponder()
        bodyField.resignFirstResponder()
        setRightBarItemSpinning()

        let signature = self.signature?.addition ?? ""

        client.createIssue(owner: owner, repo: repo, title: titleText, body: (bodyText ?? "") + signature) { [weak self] model in
            guard let strongSelf = self else { return }

            strongSelf.setRightBarItemIdle()

            guard let model = model else {
                ToastManager.showGenericError()
                return
            }

            let delegate = strongSelf.delegate
            strongSelf.dismiss(animated: true, completion: {
                delegate?.didDismissAfterCreatingIssue(model: model)
            })
        }
    }

    /// Ensures there are no unsaved changes before dismissing the view controller. Will prompt user if unsaved changes.
    @objc
    func onCancel() {
        cancelAction_onCancel(
            texts: [titleText, bodyText],
            title: NSLocalizedString("Unsaved Changes", comment: "New Issue - Cancel w/ Unsaved Changes Title"),
            message: NSLocalizedString("Are you sure you want to discard this new issue? Your message will be lost.",
                                       comment: "New Issue - Cancel w/ Unsaved Changes Message")
        )
    }

    func setupInputView() {
        let getMarkdownBlock = { [weak self] () -> (String) in
            return self?.bodyField.text ?? ""
        }
        let actions = IssueTextActionsView.forMarkdown(
            viewController: self,
            getMarkdownBlock: getMarkdownBlock,
            repo: repo,
            owner: owner,
            addBorder: true,
            supportsImageUpload: true
        )
        textActionsController.configure(textView: bodyField, actions: actions)
        textActionsController.viewController = self
        bodyField.inputAccessoryView = actions
    }

    // MARK: UITextFieldDelegate

    /// Called when the user taps return on the title field, moves their cursor to the body
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bodyField.becomeFirstResponder()
        return false
    }

    // MARK: Actions

    /// Called when editing changed on the title field, enable/disable submit button based on title text
    @IBAction func titleFieldEditingChanged(_ sender: Any) {
        navigationItem.rightBarButtonItem?.isEnabled = titleText != nil
    }

}
