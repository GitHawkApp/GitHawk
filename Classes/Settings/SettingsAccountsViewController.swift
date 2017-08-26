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
