//
//  SettingsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {

    // must be injected after init and before viewDidLoad()
    var session: GithubSession!

    let signOutIndexPath = IndexPath(item: 0, section: 0)

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //switch indexPath {
        //case signOutIndexPath: session.remove()
        //default: break
        //}
    }

}
