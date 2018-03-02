//
//  RepositoryWebViewController.swift
//  Freetime
//
//  Created by Ivan Magda on 01/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

// MARK: RepositoryWebViewController: UIViewController

final class RepositoryWebViewController: UIViewController {

    // MARK: Types

    private enum State {
        case idle
        case fetching
        case error
    }

    // MARK: Instance Variables

    private let branch: String
    private let path: FilePath
    private let repo: RepositoryDetails

    private var state = State.idle {
        didSet {
            switch state {
            case .idle, .error:
                activityIndicator.stopAnimating()
            case .fetching:
                activityIndicator.startAnimating()
            }
        }
    }

    private var resourceURL: URL? {
        get {
            guard let encodedPath = path.path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                return nil
            }

            return URL(string: "https://github.com/\(repo.owner)/\(repo.name)/raw/\(branch)/\(encodedPath)")
        }
    }

    private let webView = UIWebView()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true

        return activityIndicator
    }()

    // MARK: Init

    init(
        repo: RepositoryDetails,
        branch: String,
        path: FilePath
        ) {
        self.repo = repo
        self.branch = branch
        self.path = path
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetch()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        webView.frame = view.bounds
        activityIndicator.center = view.center
    }

    deinit {
        webView.delegate = nil
    }

}

// MARK: - RepositoryWebViewController (UIWebViewDelegate) -

extension RepositoryWebViewController: UIWebViewDelegate {

    func webViewDidStartLoad(_ webView: UIWebView) {
        state = .fetching
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        showError()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        state = .idle
    }

}

// MARK: - RepositoryWebViewController (Fetch Data) -

extension RepositoryWebViewController {

    private func fetch() {
        guard let url = resourceURL else {
            return showError(NSLocalizedString("Failed to build destination path.", comment: ""))
        }

        state = .fetching

        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }
            guard error == nil else { return strongSelf.showError() }
            guard let data = data else { return strongSelf.showError() }

            DispatchQueue.main.async {
                strongSelf.webView.load(
                    data,
                    mimeType: strongSelf.path.path.mimeType ?? "text/plain",
                    textEncodingName: "UTF-8",
                    baseURL: url
                )
            }
        }.resume()
    }

}

// MARK: - RepositoryWebViewController (Actions) -

extension RepositoryWebViewController {

    @objc private func onFileNavigationTitle(sender: UIView) {
        showAlert(filePath: path, sender: sender)
    }

}

// MARK: - RepositoryWebViewController (Private Helpers) -

extension RepositoryWebViewController {

    private func setup() {
        makeBackBarItemEmpty()
        configureTitle(
            filePath: path,
            target: self,
            action: #selector(onFileNavigationTitle(sender:))
        )

        webView.isOpaque = false
        webView.backgroundColor = .white
        webView.delegate = self

        view.backgroundColor = .white
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }

    private func showError(
        _ message: String = NSLocalizedString("Failed to execute your request.", comment: "RepositoryWebViewController fetch request.")
        ) {
        state = .error
        showAlert(
            title: NSLocalizedString("Error", comment: ""),
            message: message
        )
    }

}
