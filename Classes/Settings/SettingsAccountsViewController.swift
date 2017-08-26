//
//  SettingsAccountsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SettingsAccountsViewController: UITableViewController {

    var sessionManager: GithubSessionManager!
    var client: GithubClient!

    // MARK: Private API

    @IBAction func onAdd(_ sender: Any) {
        let alert = UIAlertController(
            title: NSLocalizedString("Add Another Account", comment: ""),
            message: NSLocalizedString("To sign in with another account, please add a new Personal Access Token.", comment: ""),
            preferredStyle: .alert
        )

        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Personal Access Token", comment: "")
        }
        alert.addAction(UIAlertAction(title: Strings.cancel, style: .cancel))

        let logInTitle = NSLocalizedString("Sign In", comment: "")
        alert.addAction(UIAlertAction(title: logInTitle, style: .default) { [weak alert, weak self] _ in
            alert?.actions.forEach { $0.isEnabled = false }

            let token = alert?.textFields?.first?.text ?? ""
            self?.client.verifyPersonalAccessToken(token: token) { result in
                self?.handle(result: result, authMethod: .pat)
            }
        })
        present(alert, animated: true)
    }

    private func handle(result: GithubClient.AccessTokenResult, authMethod: GithubUserSession.AuthMethod) {
        switch result {
        case .failure: handleError()
        case .success(let user): finishLogin(token: user.token, authMethod: authMethod, username: user.username)
        }
    }

    private func handleError() {
        let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: ""),
            message: NSLocalizedString("There was an error adding another account. Please try again.", comment: ""),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Strings.ok, style: .default))
        present(alert, animated: true)
    }

    private func finishLogin(token: String, authMethod: GithubUserSession.AuthMethod, username: String) {
        sessionManager.focus(GithubUserSession(token: token, authMethod: authMethod, username: username))
    }
    
    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionManager.userSessions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath)
        let session = sessionManager.userSessions[indexPath.row]
        cell.textLabel?.text = session.username ?? session.token
        cell.accessoryType = sessionManager.focusedUserSession == session ? .checkmark : .none
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
