//
//  2FacViewController.swift
//  Gitter
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class TwoFactorViewController: UITableViewController {

    let codeCellIndexPath = IndexPath(item: 0, section: 0)
    let verifyCellIndexPath = IndexPath(item: 0, section: 1)

    @IBOutlet weak var codeTextField: UITextField!

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == verifyCellIndexPath {
            
        }
    }

}
