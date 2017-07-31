//
//  SettingsViewController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/31/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

final class SettingsViewController2: UITableViewController {

    var sessionManager: GithubSessionManager!
    weak var rootNavigationManager: RootNavigationManager? = nil

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var reviewAccessCell: UITableViewCell!
    @IBOutlet weak var reportBugCell: UITableViewCell!
    @IBOutlet weak var viewSourceCell: UITableViewCell!
    @IBOutlet weak var signOutCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()

        versionLabel.text = Bundle.main.prettyVersionString
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        if cell === reviewAccessCell {
            onReviewAccess()
        } else if cell === reportBugCell {
            onReportBug()
        } else if cell === viewSourceCell {
            onViewSource()
        } else if cell === signOutCell {
            tableView.deselectRow(at: indexPath, animated: true)
            onSignOut()
        }
    }

    // MARK: Private API

    @IBAction func onDone(_ sender: Any) {
        dismiss(animated: true)
    }

    func onReviewAccess() {
        guard let url = URL(string: "https://github.com/settings/connections/applications/\(GithubAPI.clientID)")
            else { fatalError("Should always create GitHub issue URL") }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }

    func onReportBug() {
        let template = "\(Bundle.main.prettyVersionString)\nDevice: \(UIDevice.current.modelName) (iOS \(UIDevice.current.systemVersion)) \n"
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""

        guard let url = URL(string: "https://github.com/rnystrom/Freetime/issues/new?body=\(template)")
            else { fatalError("Should always create GitHub issue URL") }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }

    func onViewSource() {
        guard let url = URL(string: "https://github.com/rnystrom/Freetime/")
            else { fatalError("Should always create GitHub URL") }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }

    func onSignOut() {
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)

        let signoutAction = UIAlertAction(title: Strings.signout, style: .destructive) { _ in
            self.signout()
        }

        let title = NSLocalizedString("Are you sure?", comment: "")
        let message = NSLocalizedString("You will need to log in to keep using Freetime. Do you want to continue?", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(signoutAction)

        present(alert, animated: true)
    }

    func signout() {
        sessionManager.logout()
    }

}
