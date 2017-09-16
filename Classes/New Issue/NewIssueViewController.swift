//
//  NewIssueViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 15/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

enum IssueSignatureType {
    case bugReport
    case sentWithGitHawk
    
    var addition: String {
        switch self {
        case .bugReport:
            return [
                "\n",
                "```",
                "Bug Report Dump (Auto-generated):",
                Bundle.main.prettyVersionString,
                "Device: \(UIDevice.current.modelName) (iOS \(UIDevice.current.systemVersion))",
                "```"
            ].joined(separator: "\n")
        case .sentWithGitHawk:
            return Signature.signed(text: "")
        }
    }
}

class NewIssueViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextView!
    
    var client: GithubClient!
    var owner: String!
    var repo: String!
    var signature: IssueSignatureType?
    
    static func create(client: GithubClient,
                       owner: String,
                       repo: String,
                       signature: IssueSignatureType? = nil) -> NewIssueViewController? {
        let storyboard = UIStoryboard(name: "NewIssue", bundle: nil)
        
        let viewController = storyboard.instantiateInitialViewController() as? NewIssueViewController
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
            title: NSLocalizedString("Send", comment: "Send New Issue"),
            style: .done,
            target: self,
            action: #selector(send)
        )
        
        // Match Styling
        titleField.layer.borderColor = Styles.Colors.Gray.light.color.cgColor
        titleField.layer.borderWidth = 1
        titleField.layer.cornerRadius = 6
        
        bodyField.layer.borderColor = Styles.Colors.Gray.light.color.cgColor
        bodyField.layer.borderWidth = 1
        bodyField.layer.cornerRadius = 6
        bodyField.clipsToBounds = true
        
        // Add markdown controls
        setupControls()
        
        // Update Accessibility
        title = NSLocalizedString("New Issue", comment: "")
        titleField.placeholder = NSLocalizedString("Title", comment: "New Issue Title Placeholder")
        
        // Keyboard
        registerForKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Keyboard
    
    func registerForKeyboardNotifications() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: .UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillBeShown(_ notification: NSNotification) {
        guard let info = notification.userInfo, let rect = info[UIKeyboardFrameBeginUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = rect.size.height
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.scrollIndicatorInsets.bottom = keyboardHeight
    }
    
    func keyboardWillBeHidden() {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    // MARK: - Send
    
    /// Attempts to sends the current forms information to GitHub, on success will redirect the user to the new issue
    func send() {
        guard let titleText = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !titleText.isEmpty else {
            StatusBar.showError(message: NSLocalizedString("You must provide a title!", comment: "Invalid title when sending new issue"))
            return
        }
        
        let bodyText = bodyField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let signature = self.signature?.addition ?? ""
        
        client.createIssue(owner: owner, repo: repo, title: titleText, body: bodyText + signature) { [weak self] model in
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
    
    // MARK: - Actions
    
    /// Creates and adds the custom controls view for previewing, bold, etc.
    func setupControls() {
        let operations: [IssueTextActionOperation] = [
            IssueTextActionOperation(icon: UIImage(named: "bar-eye"), operation: .execute({ [weak self] in
                self?.showPreview()
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
        controlsContainerView.addSubview(actions)
        actions.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /// Presents a markdown preview of the current message
    func showPreview() {
        let controller = IssuePreviewViewController(markdown: bodyField.text)
        showDetailViewController(controller, sender: nil)
    }
}

extension NewIssueViewController: IssueTextActionsViewDelegate {
    /// Called when a user taps on one of the control buttons (preview, bold, etc)
    func didSelect(actionsView: IssueTextActionsView, operation: IssueTextActionOperation) {
        switch operation.operation {
        case .execute(let block): block()
        case .wrap(let left, let right): bodyField.replace(left: left, right: right, atLineStart: false)
        case .line(let left): bodyField.replace(left: left, right: nil, atLineStart: true)
        }
    }
}
