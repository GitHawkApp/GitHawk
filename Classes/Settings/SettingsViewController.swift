//
//  SettingsViewController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/31/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

final class SettingsViewController: UITableViewController,
NewIssueTableViewControllerDelegate {

    // must be injected
    var sessionManager: GithubSessionManager!
    weak var rootNavigationManager: RootNavigationManager? = nil

    var client: GithubClient!

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var reviewAccessCell: StyledTableCell!
    @IBOutlet weak var reportBugCell: StyledTableCell!
    @IBOutlet weak var viewSourceCell: StyledTableCell!
    @IBOutlet weak var signOutCell: StyledTableCell!
    @IBOutlet weak var backgroundFetchSwitch: UISwitch!
    @IBOutlet weak var openSettingsButton: UIButton!
    @IBOutlet weak var badgeCell: UITableViewCell!
    @IBOutlet weak var markReadSwitch: UISwitch!
    @IBOutlet weak var accountsCell: StyledTableCell!
    @IBOutlet weak var apiStatusLabel: UILabel!
    @IBOutlet weak var apiStatusView: UIView!
    @IBOutlet weak var signatureSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        versionLabel.text = Bundle.main.prettyVersionString
        markReadSwitch.isOn = NotificationClient.readOnOpen()
        apiStatusView.layer.cornerRadius = 7
        signatureSwitch.isOn = Signature.enabled

        updateBadge()
		style()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SettingsViewController.updateBadge),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
        accountsCell.detailTextLabel?.text = sessionManager.focusedUserSession?.username ?? Strings.unknown
        client?.fetchAPIStatus { [weak self] result in
            self?.update(statusResult: result)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SettingsAccountsViewController,
            let client = self.client {
            controller.client = client
            controller.sessionManager = sessionManager
        }
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        if cell === reviewAccessCell {
            onReviewAccess()
        } else if cell === reportBugCell {
            tableView.deselectRow(at: indexPath, animated: true)
            onReportBug()
        } else if cell === viewSourceCell {
            onViewSource()
        } else if cell === signOutCell {
            tableView.deselectRow(at: indexPath, animated: true)
            onSignOut()
        }
    }

    // MARK: Private API

    func onReviewAccess() {
        guard let url = URL(string: "https://github.com/settings/connections/applications/\(GithubAPI.clientID)")
            else { fatalError("Should always create GitHub issue URL") }
        presentSafari(url: url)
    }

    func onReportBug() {
        guard let client = client,
              let viewController = NewIssueTableViewController.create(client: client,
                                                                      owner: "rnystrom",
                                                                      repo: "GitHawk",
                                                                      signature: .bugReport) else {
            StatusBar.showGenericError()
            return
        }
        viewController.delegate = self
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true)
    }

    func onViewSource() {
        guard let url = URL(string: "https://github.com/rnystrom/GitHawk/")
            else { fatalError("Should always create GitHub URL") }
		presentSafari(url: url)
    }

    func onSignOut() {
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)

        let signoutAction = UIAlertAction(title: Strings.signout, style: .destructive) { _ in
            self.signout()
        }

        let title = NSLocalizedString("Are you sure?", comment: "")
        let message = NSLocalizedString("All of your accounts will be signed out. Do you want to continue?", comment: "")
        let alert = UIAlertController.configured(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(signoutAction)

        present(alert, animated: true)
    }

    func signout() {
        sessionManager.logout()
    }

    func updateBadge() {
        BadgeNotifications.check { state in
            let authorized: Bool
            let enabled: Bool
            switch state {
            case .initial:
                // throwing switch will prompt
                authorized = true
                enabled = false
            case .denied:
                authorized = false
                enabled = false
            case .disabled:
                authorized = true
                enabled = false
            case .enabled:
                authorized = true
                enabled = true
            }
            self.badgeCell.accessoryType = authorized ? .none : .disclosureIndicator
            self.openSettingsButton.isHidden = authorized
            self.backgroundFetchSwitch.isHidden = !authorized
            self.backgroundFetchSwitch.isOn = enabled
        }
    }

    @IBAction func onBackgroundFetchChanged() {
        BadgeNotifications.isEnabled = backgroundFetchSwitch.isOn
        BadgeNotifications.configure() { granted in
            self.updateBadge()
        }
    }

    @IBAction func onSettings(_ sender: Any) {
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @IBAction func onMarkRead(_ sender: Any) {
        NotificationClient.setReadOnOpen(open: markReadSwitch.isOn)
    }

    func update(statusResult: Result<GithubClient.APIStatus>) {
        switch statusResult {
        case .error:
            apiStatusView.isHidden = true
            apiStatusLabel.text = NSLocalizedString("error", comment: "")
        case .success(let status):

            let text: String
            let color: UIColor
            switch status {
            case .good:
                text = NSLocalizedString("Good", comment: "")
                color = Styles.Colors.Green.medium.color
            case .minor:
                text = NSLocalizedString("Minor", comment: "")
                color = Styles.Colors.Yellow.medium.color
            case .major:
                text = NSLocalizedString("Major", comment: "")
                color = Styles.Colors.Red.medium.color
            }
            apiStatusView.isHidden = false
            apiStatusView.backgroundColor = color
            apiStatusLabel.text = text
            apiStatusLabel.textColor = color
        }
    }
	
	private func style() {
		[backgroundFetchSwitch, markReadSwitch, signatureSwitch]
			.forEach({ $0.onTintColor = Styles.Colors.Green.medium.color })
	}

    @IBAction func onSignature(_ sender: Any) {
        Signature.enabled = signatureSwitch.isOn
    }
    
    // MARK: NewIssueTableViewControllerDelegate
    
    func didDismissAfterCreatingIssue(model: IssueDetailsModel) {
        let issuesViewController = IssuesViewController(client: client, model: model)
        let navigation = UINavigationController(rootViewController: issuesViewController)
        showDetailViewController(navigation, sender: nil)
    }
}
