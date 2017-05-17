//
//  LoginViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import OnePasswordExtension

final class LoginViewController: UITableViewController, UITextFieldDelegate {

    var client: GithubClient!

    let signinCellIndexPath = IndexPath(item: 0, section: 2)

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var onepasswordButton: UIButton!

    var textFields: [UITextField] {
        return [usernameTextField, passwordTextField]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        onepasswordButton.setImage(onePasswordButtonImage(), for: .normal)
        onepasswordButton.isHidden = !onePasswordAvailable()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TwoFactorViewController {
            controller.username = usernameTextField.text
            controller.password = passwordTextField.text
            controller.client = client
        }
    }

    // MARK: Private API

    @IBAction func onOnePassword(_ sender: Any) {
        onePasswordShow(viewController: self) { result in
            switch result {
            case .success(let username, let password):
                self.usernameTextField.text = username
                self.passwordTextField.text = password
                self.login()
            case .failure(let error):
                let message = error?.localizedDescription ?? ErrorMessages.generic
                self.showAlert(title: "1Password Error", message: message)
            case .cancelled: break
            }
        }
    }

    func viewsEnabled(_ enabled: Bool) {
        for field in textFields {
            field.isEnabled = enabled
        }
        tableView.cellForRow(at: signinCellIndexPath)?.isUserInteractionEnabled = enabled
    }

    func login() {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            username.characters.count > 0,
            password.characters.count > 0 else {
                let title = NSLocalizedString("Missing Credentials", comment: "")
                let message = NSLocalizedString("GitHub username and password are required.", comment: "")
                showAlert(title: title, message: message)
                return
        }

        showLoadingIndicator(true)
        viewsEnabled(false)

        client.requestGithubLogin(username: username, password: password) { result in
            self.showLoadingIndicator(false)
            self.viewsEnabled(true)
            self.handleResult(result)
        }
    }

    func handleResult(_ result: GithubLogin) {
        switch result {
        case .success(let auth):
            client.session.add(authorization: auth)
        case .failed:
            let title = NSLocalizedString("Sign in Error", comment: "")
            let message = NSLocalizedString("Username or password are incorrect.", comment: "")
            showAlert(title: title, message: message)
        case .twoFactor:
            performSegue(withIdentifier: "show2fac", sender: nil)
        }
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // iterate through the text fields, focus on the next field
        let fields = textFields
        var focusNext = false
        for field in fields {
            if focusNext {
                field.becomeFirstResponder()
            } else if textField === field {
                focusNext = true
            }
        }

        // finish login if on the last field
        if textField === fields.last {
            textField.resignFirstResponder()
            login()
        }

        return false
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == signinCellIndexPath {
            login()
        }
    }
    
}
