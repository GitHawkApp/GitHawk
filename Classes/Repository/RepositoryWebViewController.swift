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

    private let webView = UIWebView()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true

        return activityIndicator
    }()

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
        let url = URL(string: "https://github.com/vanyaland/mlcourse_open_homeworks/raw/master/notes/1-1.Vvedenie.pdf")!
        state = .fetching

        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }
            guard error == nil else { return strongSelf.showError() }
            guard let data = data else { return strongSelf.showError() }

            DispatchQueue.main.async {
                strongSelf.webView.load(
                    data,
                    mimeType: "application/pdf",
                    textEncodingName: "UTF-8",
                    baseURL: url
                )
            }
        }.resume()
    }

}

// MARK: - RepositoryWebViewController (Private Helpers) -

extension RepositoryWebViewController {

    private func setup() {
        makeBackBarItemEmpty()
        view.backgroundColor = .white

        webView.isOpaque = false
        webView.backgroundColor = .white
        webView.delegate = self
        view.addSubview(webView)

        view.addSubview(activityIndicator)
    }

    private func showError() {
        state = .error
        showAlert(
            title: NSLocalizedString("Error", comment: ""),
            message: NSLocalizedString("Failed to execute your request.", comment: "RepositoryWebViewController fetch request.")
        )
    }

}
