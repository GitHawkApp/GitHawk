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

    @IBOutlet weak var tokenTextField: UITextField!
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
    }

    // MARK: Private API

    @IBAction func onSignInButton(_ sender: Any) {
        if let token = tokenTextField.text, !token.isEmpty {
            finishLogin(token: token, authMethod: .pat)
        } else {
            let safari = SFSafariViewController(url: loginURL)
            safariController = safari
            present(safari, animated: true)
        }
    }

    private func handle(result: GithubClient.AccessTokenResult) {
        switch result {
        case .failure: handleError()
        case .success(let token): finishLogin(token: token, authMethod: .oauth)
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
        present(alert, animated: true)
    }

    private func finishLogin(token: String, authMethod: GithubUserSession.AuthMethod) {
        client.sessionManager.authenticate(token, authMethod: authMethod)
    }

    // MARK: GithubSessionListener

    func didReceiveRedirect(manager: GithubSessionManager, code: String) {
        safariController?.dismiss(animated: true)
        state = .fetchingToken

        client.requestAccessToken(code: code) { result in
            self.handle(result: result)
        }
    }

    func didAuthenticate(manager: GithubSessionManager, userSession: GithubUserSession) {}
    func didLogout(manager: GithubSessionManager) {}

}
