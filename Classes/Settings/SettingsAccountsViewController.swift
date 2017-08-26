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

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sessionManager.userSessions.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isAccounts = indexPath.section == 0
        let identifier = isAccounts ? "account" : "add-account"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if isAccounts {
            let session = sessionManager.userSessions[indexPath.row]
            cell.textLabel?.text = session.username ?? session.token
            cell.accessoryType = sessionManager.focusedUserSession == session ? .checkmark : .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("Authenticated Accounts", comment: "")
        } else {
            return nil
        }
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {

        } else {

        }
    }

}
