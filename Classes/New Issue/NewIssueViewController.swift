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

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(send))
    }
    
    func send() {
        guard let titleText = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !titleText.isEmpty else {
            StatusBar.showError(message: NSLocalizedString("You must provide a title!", comment: ""))
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
            
            // Replace "New Issue" VC with "Display Issue" VC
            var viewControllers = navController.viewControllers
            viewControllers[viewControllers.count - 1] = issuesViewController
            navController.setViewControllers(viewControllers, animated: true)
        }
    }

}
