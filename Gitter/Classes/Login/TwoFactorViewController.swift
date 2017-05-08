//
//  2FacViewController.swift
//  Gitter
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class TwoFactorViewController: UITableViewController, UITextFieldDelegate {

    var username: String!
    var password: String!

    let codeCellIndexPath = IndexPath(item: 0, section: 0)
    let verifyCellIndexPath = IndexPath(item: 0, section: 1)

    @IBOutlet weak var codeTextField: UITextField!

    // MARK: Private API

    func login() {
        guard let code = codeTextField.text,
            code.characters.count > 0 else {
                let title = NSLocalizedString("Missing Code", comment: "")
                let message = NSLocalizedString("A valid two-factor code is required.", comment: "")
                showAlert(title: title, message: message)
                return
        }

        codeTextField.isEnabled = false
        showLoadingIndicator(true)

        requestGithubLogin(username: username, password: password, twoFactorCode: code) { result in
            self.codeTextField.isEnabled = true
            self.showLoadingIndicator(false)
            self.handleResult(result)
        }
    }

    func handleResult(_ result: GithubLogin) {
        switch result {
        case .success(let auth):
            print(auth)
        default:
            let title = NSLocalizedString("Two-factor Error", comment: "")
            let message = NSLocalizedString("Unable to verify your account.", comment: "")
            showAlert(title: title, message: message)
        }
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        login()
        return false
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == verifyCellIndexPath {
            login()
        }
    }
    
}
