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

class NewIssueTableViewController: UITableViewController, UITextFieldDelegate, IssueTextActionsViewDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextView!
    
    var client: GithubClient!
    var owner: String!
    var repo: String!
    var signature: IssueSignatureType?
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Send", comment: ""),
            style: .done,
            target: self,
            action: #selector(send)
        )
        
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
        setupInputView()
        
        // Update title to use localization
        title = NSLocalizedString("New Issue", comment: "")
    }
    
    // MARK: - Buttons
    
    /// Attempts to sends the current forms information to GitHub, on success will redirect the user to the new issue
    func send() {
        guard let titleText = titleText else {
            StatusBar.showError(message: NSLocalizedString("You must provide a title!", comment: "Invalid title when sending new issue"))
            return
        }
        
        let signature = self.signature?.addition ?? ""
        
        client.createIssue(owner: owner, repo: repo, title: titleText, body: (bodyText ?? "") + signature) { [weak self] model in
            guard let weakSelf = self, let navController = weakSelf.navigationController else { return }
            
            guard let model = model else {
                StatusBar.showGenericError()
                return
            }
            
            let issuesViewController = IssuesViewController(client: weakSelf.client, model: model)
            issuesViewController.hidesBottomBarWhenPushed = true
            
            navController.replaceTopMostViewController(issuesViewController, animated: true)
        }
    }

    /// Ensures there are no unsaved changes before dismissing the view controller. Will prompt user if unsaved changes.
    func cancel() {
        if titleText == nil && bodyText == nil {
            _ = navigationController?.popViewController(animated: true)
            return
        }
        
        let title = NSLocalizedString("Unsaved Changes", comment: "New Issue - Cancel w/ Unsaved Changes Title")
        let message = NSLocalizedString("Are you sure you want to cancel this new issue? Your message will be lost.", comment: "New Issue - Cancel w/ Unsaved Changes Message")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .destructive, handler: { [weak self] _ in
            _ = self?.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Markdown
    
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
        actions.delegate = self
        actions.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        actions.backgroundColor = .white
        bodyField.inputAccessoryView = actions
    }
    
    // MARK: - UITextFieldDelegate
    
    /// Called when the user taps return on the title field, moves their cursor to the body
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bodyField.becomeFirstResponder()
        return false
    }
    
    // MARK: - IssueTextActionsViewDelegate
    
    /// Called when a user taps on one of the control buttons (preview, bold, etc)
    func didSelect(actionsView: IssueTextActionsView, operation: IssueTextActionOperation) {
        switch operation.operation {
        case .execute(let block): block()
        case .wrap(let left, let right): bodyField.replace(left: left, right: right, atLineStart: false)
        case .line(let left): bodyField.replace(left: left, right: nil, atLineStart: true)
        }
    }
}
