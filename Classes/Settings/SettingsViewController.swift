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
    weak var rootNavigationManager: RootNavigationManager?

    var client: GithubClient!

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var reviewAccessCell: StyledTableCell!
    @IBOutlet weak var githubStatusCell: StyledTableCell!
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
            name: .UIApplicationDidBecomeActive,
            object: nil
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
        accountsCell.detailTextLabel?.text = sessionManager.focusedUserSession?.username ?? Constants.Strings.unknown
        client?.fetchAPIStatus { [weak self] result in
            self?.update(statusResult: result)
        }
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func deselectRow() { tableView.deselectRow(at: indexPath, animated: trueUnlessReduceMotionEnabled) }
        let cell = tableView.cellForRow(at: indexPath)

        if cell === reviewAccessCell {
            deselectRow()
            onReviewAccess()
        } else if cell === accountsCell {
            deselectRow()
            onAccounts()
        } else if cell === githubStatusCell {
            deselectRow()
            onGitHubStatus()
        } else if cell === reportBugCell {
            deselectRow()
            onReportBug()
        } else if cell === viewSourceCell {
            onViewSource()
        } else if cell === signOutCell {
            deselectRow()
            onSignOut()
        }
    }

    // MARK: Private API

    func onReviewAccess() {
        guard let url = GithubClient.url(path: "settings/connections/applications/\(Secrets.GitHub.clientId)")
            else { fatalError("Should always create GitHub issue URL") }
        // iOS 11 login uses SFAuthenticationSession which shares credentials with Safari.app
        UIApplication.shared.open(url, options: [:])
        
    }

    func onAccounts() {
        if let navigationController = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "accountsNavigationController") as? UINavigationController,
            let accountsController = navigationController.topViewController as? SettingsAccountsViewController,
            let client = self.client {
            accountsController.client = client
            accountsController.sessionManager = sessionManager
            self.navigationController?.showDetailViewController(navigationController, sender: self)
        }
    }
    
    func onGitHubStatus() {
        guard let url = GithubClient.url(baseURL: "https://status.github.com/", path: "messages")
            else { fatalError("Should always create GitHub Status URL") }
        presentSafari(url: url)
    }

    func onReportBug() {
        guard let client = client,
            let viewController = NewIssueTableViewController.create(
                client: client,
                owner: "rnystrom",
                repo: "GitHawk",
                signature: .bugReport
            ) else {
                ToastManager.showGenericError()
                return
        }
        viewController.delegate = self
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: trueUnlessReduceMotionEnabled)
    }

    func onViewSource() {
        guard let url = URL(string: Constants.URLs.repository)
            else { fatalError("Should always create GitHub URL") }
		presentSafari(url: url)
    }

    func onSignOut() {
        let title = NSLocalizedString("Are you sure?", comment: "")
        let message = NSLocalizedString("All of your accounts will be signed out. Do you want to continue?", comment: "")
        let alert = UIAlertController.configured(title: title, message: message, preferredStyle: .alert)
        alert.addActions([
            AlertAction.cancel(),
            AlertAction(AlertActionBuilder {
                $0.title = Constants.Strings.signout
                $0.style = .destructive
            }).get { [weak self] _ in
                self?.signout()
            }
        ])

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    func signout() {
        sessionManager.logout()
    }

    @objc func updateBadge() {
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
        BadgeNotifications.configure { _ in
            self.updateBadge()
        }
    }

    @IBAction func onSettings(_ sender: Any) {
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
        UIApplication.shared.open(url)
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
