//
//  LoginViewController.swift
//  Gitter
//
//  Created by Ryan Nystrom on 5/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class LoginViewController: UITableViewController {

    let usernameCellIndexPath = IndexPath(item: 0, section: 0)
    let passwordCellIndexPath = IndexPath(item: 0, section: 0)
    let signinCellIndexPath = IndexPath(item: 0, section: 0)

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!

    // MARK: Private API

    @IBAction func onOnePassword(_ sender: Any) {
        
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == signinCellIndexPath {

        }
    }

}
