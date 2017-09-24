//
//  LoginSplashViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

private let loginURL = URL(string: "http://github.com/login/oauth/authorize?client_id=\(GithubAPI.clientID)&scope=user+repo+notifications")!

final class LoginSplashViewController: UIViewController, GithubSessionListener {

    enum State {
        case idle
        case fetchingToken
    }

    var client: GithubClient!

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private weak var safariController: SFSafariViewController? = nil

    var state: State = .idle {
        didSet {
            let hideSpinner: Bool
            switch state {
            case .idle: hideSpinner = true
            case .fetchingToken: hideSpinner = false
            }
            signInButton.isEnabled = hideSpinner
            activityIndicator.isHidden = hideSpinner

            let title = hideSpinner
                ? NSLocalizedString("Sign in with GitHub", comment: "")
                : NSLocalizedString("Signing in...", comment: "")
            signInButton.setTitle(title, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        state = .idle
        client.sessionManager.addListener(listener: self)
        signInButton.layer.cornerRadius = Styles.Sizes.eventGutter
    }

    // MARK: Private API

    @IBAction func onSignInButton(_ sender: Any) {
        let safari = SFSafariViewController(url: loginURL)
        safariController = safari
        present(safari, animated: true)
    }

    @IBAction func onPersonalAccessTokenButton(_ sender: Any) {
        let alert = UIAlertController(
            title: NSLocalizedString("Personal Access Token", comment: ""),
            message: NSLocalizedString("Sign in with a Personal Access Token with both repo and user scopes.", comment: ""),
            preferredStyle: .alert
        )

        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Personal Access Token", comment: "")
        }
        alert.addAction(UIAlertAction(title: Strings.cancel, style: .cancel))

        let logInTitle = NSLocalizedString("Sign In", comment: "")
        alert.addAction(UIAlertAction(title: logInTitle, style: .default) { [weak alert, weak self] _ in
            alert?.actions.forEach { $0.isEnabled = false }

            self?.state = .fetchingToken

            let token = alert?.textFields?.first?.text ?? ""
            self?.client.verifyPersonalAccessToken(token: token) { result in
                self?.handle(result: result, authMethod: .pat)
            }
        })
		alert.view.tintColor = Styles.Colors.Blue.medium.color
        present(alert, animated: true)
    }

    private func handle(result: Result<GithubClient.AccessTokenUser>, authMethod: GithubUserSession.AuthMethod) {
        switch result {
        case .error: handleError()
        case .success(let user): finishLogin(token: user.token, authMethod: authMethod, username: user.username)
        }
    }

    private func handleError() {
        state = .idle

        let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: ""),
            message: NSLocalizedString("There was an error signing in to GitHub. Please try again.", comment: ""),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Strings.ok, style: .default))
		alert.view.tintColor = Styles.Colors.Blue.medium.color
        present(alert, animated: true)
    }

    private func finishLogin(token: String, authMethod: GithubUserSession.AuthMethod, username: String) {
        client.sessionManager.focus(
            GithubUserSession(token: token, authMethod: authMethod, username: username),
            dismiss: true
        )
    }

    // MARK: GithubSessionListener

    func didReceiveRedirect(manager: GithubSessionManager, code: String) {
        safariController?.dismiss(animated: true)
        state = .fetchingToken

        client.requestAccessToken(code: code) { result in
            self.handle(result: result, authMethod: .oauth)
        }
    }

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession, dismiss: Bool) {}
    func didLogout(manager: GithubSessionManager) {}

}
