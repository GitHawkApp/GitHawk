//
//  SettingsAccountsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SettingsAccountsViewController: UITableViewController, GithubSessionListener {

    var client: GithubClient!
    var sessionManager: GithubSessionManager! {
        didSet {
            sessionManager.addListener(listener: self)
            updateUserSessions()
        }
    }
    private var userSessions = [GithubUserSession]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Accounts", comment: "")
    }

    // MARK: Private API

    @IBAction func onAdd(_ sender: Any) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Add Account", comment: ""),
            message: NSLocalizedString("To sign in with another account, please add a new Personal Access Token with user and repo scopes.", comment: ""),
            preferredStyle: .alert
        )

        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Personal Access Token", comment: "")
        }
        alert.addActions([
            AlertAction.cancel(),
            AlertAction.login({ [weak alert, weak self] _ in
                alert?.actions.forEach { $0.isEnabled = false }

                let token = alert?.textFields?.first?.text ?? ""
                self?.client.verifyPersonalAccessToken(token: token) { result in
                    self?.handle(result: result, authMethod: .pat)
                }
            })
        ])

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func handle(result: Result<GithubClient.AccessTokenUser>, authMethod: GithubUserSession.AuthMethod) {
        switch result {
        case .error: handleError()
        case .success(let user): finishLogin(token: user.token, authMethod: authMethod, username: user.username)
        }
    }

    private func handleError() {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Error", comment: ""),
            message: NSLocalizedString("There was an error adding another account. Please try again.", comment: ""),
            preferredStyle: .alert
        )
        alert.addAction(AlertAction.ok())
        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func finishLogin(token: String, authMethod: GithubUserSession.AuthMethod, username: String) {
        sessionManager.focus(
            GithubUserSession(token: token, authMethod: authMethod, username: username),
            dismiss: false
        )
    }

    private func updateUserSessions() {
        userSessions = sessionManager.userSessions.sorted(by: { (left, right) -> Bool in
            return (left.username ?? "") < (right.username ?? "")
        })
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionManager.userSessions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath)
        let session = userSessions[indexPath.row]
        cell.textLabel?.text = session.username ?? session.token
        cell.accessoryType = sessionManager.focusedUserSession == session ? .checkmark : .none
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: trueUnlessReduceMotionEnabled)

        let selectedSession = userSessions[indexPath.row]
        guard selectedSession != sessionManager.focusedUserSession else { return }
        sessionManager.focus(selectedSession, dismiss: false)
    }

    // MARK: GithubSessionListener

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession, dismiss: Bool) {
        updateUserSessions()
        tableView.reloadData()
    }

    func didReceiveRedirect(manager: GithubSessionManager, code: String) {}
    func didLogout(manager: GithubSessionManager) {}

}
