//
//  SettingsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/31/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices
import GitHubAPI
import GitHubSession
import Squawk

final class SettingsViewController: UITableViewController,
NewIssueTableViewControllerDelegate {

    // must be injected
    var sessionManager: GitHubSessionManager!
    weak var rootNavigationManager: RootNavigationManager?

    var client: GithubClient!

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var reviewAccessCell: StyledTableCell!
    @IBOutlet weak var githubStatusCell: StyledTableCell!
    @IBOutlet weak var reviewOnAppStoreCell: StyledTableCell!
    @IBOutlet weak var reportBugCell: StyledTableCell!
    @IBOutlet weak var viewSourceCell: StyledTableCell!
    @IBOutlet weak var setDefaultReaction: StyledTableCell!
    @IBOutlet weak var signOutCell: StyledTableCell!
    @IBOutlet weak var backgroundFetchSwitch: UISwitch!
    @IBOutlet weak var openSettingsButton: UIButton!
    @IBOutlet weak var badgeCell: UITableViewCell!
    @IBOutlet weak var markReadSwitch: UISwitch!
    @IBOutlet weak var accountsCell: StyledTableCell!
    @IBOutlet weak var apiStatusLabel: UILabel!
    @IBOutlet weak var apiStatusView: UIView!
    @IBOutlet weak var signatureSwitch: UISwitch!
    @IBOutlet weak var defaultReactionLabel: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        versionLabel.text = Bundle.main.prettyVersionString
        markReadSwitch.isOn = NotificationModelController.readOnOpen
        apiStatusView.layer.cornerRadius = 7
        signatureSwitch.isOn = Signature.enabled
        defaultReactionLabel.text = ReactionContent.defaultReaction.emoji

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

        client.client.send(GitHubAPIStatusRequest()) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .failure:
                strongSelf.apiStatusView.isHidden = true
                strongSelf.apiStatusLabel.text = NSLocalizedString("error", comment: "")
            case .success(let response):
                let text: String
                let color: UIColor
                switch response.data.status {
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
                strongSelf.apiStatusView.isHidden = false
                strongSelf.apiStatusView.backgroundColor = color
                strongSelf.apiStatusLabel.text = text
                strongSelf.apiStatusLabel.textColor = color
            }
        }
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: trueUnlessReduceMotionEnabled)
        let cell = tableView.cellForRow(at: indexPath)

        if cell === reviewAccessCell {
            onReviewAccess()
        } else if cell === accountsCell {
            onAccounts()
        } else if cell === githubStatusCell {
            onGitHubStatus()
        } else if cell === reviewOnAppStoreCell {
            onReviewOnAppStore()
        } else if cell === reportBugCell {
            onReportBug()
        } else if cell === viewSourceCell {
            onViewSource()
        } else if cell === setDefaultReaction {
            onSetDefaultReaction()
        } else if cell === signOutCell {
            onSignOut()
        }
    }

    // MARK: Private API

    func onReviewAccess() {
        guard let url = URL(string: "https://github.com/settings/connections/applications/\(Secrets.GitHub.clientId)")
            else { fatalError("Should always create GitHub issue URL") }
        // iOS 11 login uses SFAuthenticationSession which shares credentials with Safari.app
        UIApplication.shared.open(url, options: [:])
        
    }

    func onAccounts() {
        if let navigationController = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "accountsNavigationController") as? UINavigationController,
            let accountsController = navigationController.topViewController as? SettingsAccountsViewController,
            let client = self.client {
            accountsController.config(client: client.client, sessionManager: sessionManager)
            self.navigationController?.showDetailViewController(navigationController, sender: self)
        }
    }
    
    func onGitHubStatus() {
        guard let url = URL(string: "https://status.github.com/messages")
            else { fatalError("Should always create GitHub Status URL") }
        presentSafari(url: url)
    }
  
    func onReviewOnAppStore() {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id1252320249?action=write-review")
            else { fatalError("Should always be valid app store URL") }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    func onReportBug() {
        guard let client = client,
            let viewController = NewIssueTableViewController.create(
                client: client,
                owner: "GitHawkApp",
                repo: "GitHawk",
                signature: .bugReport
            ) else {
                Squawk.showGenericError()
                return
        }
        viewController.delegate = self
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: trueUnlessReduceMotionEnabled)
    }

    func onViewSource() {
        guard let client = client else {
            Squawk.showGenericError()
            return
        }

        let repo = RepositoryDetails(
            owner: "GitHawkApp",
            name: "GitHawk",
            defaultBranch: "master",
            hasIssuesEnabled: true
        )
        let repoViewController = RepositoryViewController(client: client, repo: repo)
        navigationController?.showDetailViewController(repoViewController, sender: self)
    }
  
    func onSetDefaultReaction() {
      showDefaultReactionMenu()
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
        NotificationModelController.setReadOnOpen(open: markReadSwitch.isOn)
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

extension SettingsViewController {
  // Default Reaction + MenuController
  
   private func showDefaultReactionMenu() {
    
    setDefaultReaction.becomeFirstResponder() // Required
    
    let actions = [
      (ReactionContent.thumbsUp.emoji, #selector(SettingsViewController.onThumbsUp)),
      (ReactionContent.thumbsDown.emoji, #selector(SettingsViewController.onThumbsDown)),
      (ReactionContent.laugh.emoji, #selector(SettingsViewController.onLaugh)),
      (ReactionContent.hooray.emoji, #selector(SettingsViewController.onHooray)),
      (ReactionContent.confused.emoji, #selector(SettingsViewController.onConfused)),
      (ReactionContent.heart.emoji, #selector(SettingsViewController.onHeart)),
      ("Disable", #selector(SettingsViewController.onDisabled))
    ]
    
    let menu = UIMenuController.shared
    menu.menuItems = actions.map { UIMenuItem(title: $0.0, action: $0.1) }
    menu.setTargetRect(defaultReactionLabel.frame, in: setDefaultReaction)
    menu.setMenuVisible(true, animated: trueUnlessReduceMotionEnabled)
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    switch action {
    case #selector(SettingsViewController.onThumbsUp),
         #selector(SettingsViewController.onThumbsDown),
         #selector(SettingsViewController.onLaugh),
         #selector(SettingsViewController.onHooray),
         #selector(SettingsViewController.onConfused),
         #selector(SettingsViewController.onHeart),
         #selector(SettingsViewController.onDisabled):
      return true
    default: return false
    }
  }
  
  @objc private func onThumbsUp() {
    updateDefaultReaction(.thumbsUp)
  }
  
  @objc private func onThumbsDown() {
    updateDefaultReaction(.thumbsDown)
  }
  
  @objc private func onLaugh() {
    updateDefaultReaction( .laugh)
  }
  
  @objc private func onHooray() {
    updateDefaultReaction(.hooray)
  }
  
  @objc private func onConfused() {
    updateDefaultReaction(.confused)
  }
  
  @objc private func onHeart() {
   updateDefaultReaction(.heart)
  }
  
  @objc private func onDisabled() {
    updateDefaultReaction(.__unknown("Disabled"))
  }
  
  func updateDefaultReaction(_ reaction: ReactionContent)
  {
    UserDefaults.setDefault(reaction: reaction)
    defaultReactionLabel.text = reaction == .__unknown("Disabled")
      ? "Disabled"
      : reaction.emoji
  }
}
