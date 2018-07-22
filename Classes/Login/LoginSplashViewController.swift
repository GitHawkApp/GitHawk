//
//  LoginSplashViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices
import GitHubAPI
import GitHubSession

private let loginURL = URL(string: "http://github.com/login/oauth/authorize?client_id=\(Secrets.GitHub.clientId)&scope=user+repo+notifications")!
private let callbackURLScheme = "freetime://"

final class LoginSplashViewController: UIViewController, GitHubSessionListener {

    enum State {
        case idle
        case fetchingToken
    }

    private var client: Client!
    private var sessionManager: GitHubSessionManager!

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private weak var safariController: SFSafariViewController?

    @available(iOS 11.0, *)
    private var authSession: SFAuthenticationSession? {
        get {
            return _authSession as? SFAuthenticationSession
        }
        set {
            _authSession = newValue
        }
    }
    private var _authSession: Any?

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
        sessionManager.addListener(listener: self)
        signInButton.layer.cornerRadius = Styles.Sizes.cardCornerRadius
    }

    // MARK: Public API

    func config(client: Client, sessionManager: GitHubSessionManager) {
        self.client = client
        self.sessionManager = sessionManager
    }

    // MARK: Private API

    @IBAction func onSignInButton(_ sender: Any) {
        self.authSession = SFAuthenticationSession(url: loginURL, callbackURLScheme: callbackURLScheme, completionHandler: { [weak self] (callbackUrl, error) in
            guard error == nil, let callbackUrl = callbackUrl else {
                switch error! {
                case SFAuthenticationError.canceledLogin: break
                default: self?.handleError()
                }
                return
            }
            self?.sessionManager.receivedCodeRedirect(url: callbackUrl)
        })
        self.authSession?.start()
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
                self?.client.send(V3VerifyPersonalAccessTokenRequest(token: token)) { result in
                    switch result {
                    case .failure:
                        self?.handleError()
                    case .success(let user):
                        self?.finishLogin(token: token, authMethod: .pat, username: user.data.login)
                    }
                }
            })
        ])

        present(alert, animated: trueUnlessReduceMotionEnabled)
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

    private func finishLogin(token: String, authMethod: GitHubUserSession.AuthMethod, username: String) {
        sessionManager.focus(
            GitHubUserSession(token: token, authMethod: authMethod, username: username),
            dismiss: true
        )
    }

    // MARK: GitHubSessionListener

    func didReceiveRedirect(manager: GitHubSessionManager, code: String) {
        safariController?.dismiss(animated: trueUnlessReduceMotionEnabled)
        state = .fetchingToken

        client.requestAccessToken(code: code) { [weak self] result in
            switch result {
            case .error:
                self?.handleError()
            case .success(let user):
                self?.finishLogin(token: user.token, authMethod: .oauth, username: user.username)
            }
        }
    }

    func didFocus(manager: GitHubSessionManager, userSession: GitHubUserSession, dismiss: Bool) {}
    func didLogout(manager: GitHubSessionManager) {}

}
