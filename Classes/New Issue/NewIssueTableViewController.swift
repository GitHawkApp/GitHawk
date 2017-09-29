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

final class NewIssueTableViewController: UITableViewController, UITextFieldDelegate, IssueTextActionsViewDelegate {

    weak var delegate: NewIssueTableViewControllerDelegate? = nil

    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextView!
    
    private var client: GithubClient!
    private var owner: String!
    private var repo: String!
    private var signature: IssueSignatureType?
    
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
            title: NSLocalizedString("Cancel", comment: ""),
            style: .plain,
            target: self,
            action: #selector(cancel)
        )
        
        // Make the return button move on to description field
        titleField.delegate = self
        
        // Setup markdown input view
        bodyField.contentInset = .zero
        bodyField.textContainerInset = .zero
        bodyField.textContainer.lineFragmentPadding = 0
        setupInputView()
        
        // Update title to use localization
        title = NSLocalizedString("New Issue", comment: "")
    }
    
    // MARK: Private API

    func setRightBarItemSpinning() {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
    }

    func setRightBarItemIdle() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Submit", comment: ""),
            style: .done,
            target: self,
            action: #selector(send)
        )
    }
    
    /// Attempts to sends the current forms information to GitHub, on success will redirect the user to the new issue
    func send() {
        guard let titleText = titleText else {
            StatusBar.showError(message: NSLocalizedString("You must provide a title!", comment: "Invalid title when sending new issue"))
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
                StatusBar.showGenericError()
                return
            }

            let delegate = strongSelf.delegate
            strongSelf.dismiss(animated: true, completion: {
                delegate?.didDismissAfterCreatingIssue(model: model)
            })
        }
    }

    /// Ensures there are no unsaved changes before dismissing the view controller. Will prompt user if unsaved changes.
    func cancel() {
        let dismissBlock = {
            self.dismiss(animated: true)
        }

        if titleText == nil && bodyText == nil {
            dismissBlock()
            return
        }
        
        let title = NSLocalizedString("Unsaved Changes", comment: "New Issue - Cancel w/ Unsaved Changes Title")
        let message = NSLocalizedString("Are you sure you want to discard this new issue? Your message will be lost.", comment: "New Issue - Cancel w/ Unsaved Changes Message")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addActions([
            AlertAction.goBack(),
            AlertAction.discard { _ in
                dismissBlock()
            }
        ])
        
        present(alert, animated: true, completion: nil)
    }
    
    func setupInputView() {
        let operations: [IssueTextActionOperation] = [
            IssueTextActionOperation(icon: UIImage(named: "bar-eye"), operation: .execute({ [weak self] in
                guard let strongSelf = self else { return }
                let controller = IssuePreviewViewController(markdown: strongSelf.bodyField.text, owner: strongSelf.owner, repo: strongSelf.repo)
                strongSelf.showDetailViewController(controller, sender: nil)
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
        ]
        
        let actions = IssueTextActionsView(operations: operations)
        actions.backgroundColor = Styles.Colors.Gray.lighter.color
        actions.delegate = self
        actions.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        actions.addBorder(.top)
        bodyField.inputAccessoryView = actions
    }
    
    // MARK: UITextFieldDelegate
    
    /// Called when the user taps return on the title field, moves their cursor to the body
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bodyField.becomeFirstResponder()
        return false
    }
    
    // MARK: IssueTextActionsViewDelegate
    
    /// Called when a user taps on one of the control buttons (preview, bold, etc)
    func didSelect(actionsView: IssueTextActionsView, operation: IssueTextActionOperation) {
        switch operation.operation {
        case .execute(let block): block()
        case .wrap(let left, let right): bodyField.replace(left: left, right: right, atLineStart: false)
        case .line(let left): bodyField.replace(left: left, right: nil, atLineStart: true)
        }
    }
}
