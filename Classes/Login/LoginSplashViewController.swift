//
//  LoginSplashViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

private let loginURL = URL(string: "http://github.com/login/oauth/authorize?client_id=\(Secrets.GitHub.clientId)&scope=user+repo+notifications")!
private let callbackURLScheme = "freetime://"

final class LoginSplashViewController: UIViewController, GithubSessionListener {

    enum State {
        case idle
        case fetchingToken
    }

    var client: GithubClient!

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private weak var safariController: SFSafariViewController?

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
        guard let safariController = try? SFSafariViewController.configured(with: loginURL) else { return }
        self.safariController = safariController
        present(safariController, animated: trueUnlessReduceMotionEnabled)
    }

    @IBAction func onPersonalAccessTokenButton(_ sender: Any) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Personal Access Token", comment: ""),
            message: NSLocalizedString("Sign in with a Personal Access Token with both repo and user scopes.", comment: ""),
            preferredStyle: .alert
        )

        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Personal Access Token", comment: "")
        }

        alert.addActions([
            AlertAction.cancel(),
            AlertAction.login({ [weak alert, weak self] _ in
                alert?.actions.forEach { $0.isEnabled = false }

                self?.state = .fetchingToken

                let token = alert?.textFields?.first?.text ?? ""
                self?.client.verifyPersonalAccessToken(token: token) { result in
                    self?.handle(result: result, authMethod: .pat)
                }
            })
        ])

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func handle(result: Result<GithubClient.AccessTokenUser>, authMethod: GithubUserSession.AuthMethod) {
        switch result {
        case .error: handleError()
        case .success(let user): finishLogin(token: user.token, authMethod: authMethod, username: user.username)
        }
    }

    private func handleError() {
        state = .idle

        let alert = UIAlertController.configured(
            title: NSLocalizedString("Error", comment: ""),
            message: NSLocalizedString("There was an error signing in to GitHub. Please try again.", comment: ""),
            preferredStyle: .alert
        )
        alert.addAction(AlertAction.ok())
        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func finishLogin(token: String, authMethod: GithubUserSession.AuthMethod, username: String) {
        client.sessionManager.focus(
            GithubUserSession(token: token, authMethod: authMethod, username: username),
            dismiss: true
        )
    }

    // MARK: GithubSessionListener

    func didReceiveRedirect(manager: GithubSessionManager, code: String) {
        safariController?.dismiss(animated: trueUnlessReduceMotionEnabled)
        state = .fetchingToken

        client.requestAccessToken(code: code) { result in
            self.handle(result: result, authMethod: .oauth)
        }
    }

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession, dismiss: Bool) {}
    func didLogout(manager: GithubSessionManager) {}

}
