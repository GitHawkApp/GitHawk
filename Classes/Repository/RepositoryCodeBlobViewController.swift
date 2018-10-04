//
//  RepositoryCodeBlobViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Squawk

final class RepositoryCodeBlobViewController: UIViewController, EmptyViewDelegate {

    private let client: GithubClient
    private let branch: String
    private let path: FilePath
    private let repo: RepositoryDetails
    private let codeView = CodeView()
    private let feedRefresh = FeedRefresh()
    private let emptyView = EmptyView()
    private var sharingPayload: Any?
    private lazy var sharingButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(RepositoryCodeBlobViewController.onShare(sender:)))
        barButtonItem.isEnabled = false

        return barButtonItem
    }()

    init(
        client: GithubClient,
        repo: RepositoryDetails,
        branch: String,
        path: FilePath
        ) {
        self.client = client
        self.repo = repo
        self.branch = branch
        self.path = path
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeBackBarItemEmpty()
        configureTitle(filePath: path, target: self, action: #selector(onFileNavigationTitle(sender:)))

        view.backgroundColor = .white

        emptyView.isHidden = true
        emptyView.delegate = self
        emptyView.button.isHidden = false
        view.addSubview(emptyView)
        view.addSubview(codeView)

        codeView.refreshControl = feedRefresh.refreshControl
        feedRefresh.refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)

        navigationItem.rightBarButtonItem = sharingButton

        fetch()
        feedRefresh.beginRefreshing()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let frame: CGRect
        if #available(iOS 11, *) {
            frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            frame = view.bounds
        }
        
        emptyView.frame = frame
        codeView.frame = frame
    }

    // MARK: Private API

    @objc func onFileNavigationTitle(sender: UIView) {
        showAlert(filePath: path, sender: sender)
    }

    func didFetchPayload(_ payload: Any) {
        sharingPayload = payload
        sharingButton.isEnabled = true
    }

    @objc func onRefresh() {
        fetch()
    }

    @objc func onShare(sender: UIBarButtonItem) {
        guard let payload = sharingPayload else { return }
        let activityController = UIActivityViewController(activityItems: [payload], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = sender

        present(activityController, animated: trueUnlessReduceMotionEnabled)
    }

    func fetch() {
        client.fetchFile(
        owner: repo.owner,
        repo: repo.name,
        branch: branch,
        path: path.path
        ) { [weak self] (result) in
            self?.feedRefresh.endRefreshing()
            switch result {
            case .success(let text):
                self?.handle(text: text)
            case .nonUTF8:
                self?.error(cannotLoad: true)
            case .error:
                self?.error(cannotLoad: false)
                Squawk.showGenericError()
            }
        }
    }

    func error(cannotLoad: Bool) {
        emptyView.isHidden = false
        emptyView.label.text = cannotLoad
            ? NSLocalizedString("Cannot display file as text", comment: "")
            : NSLocalizedString("Error loading file", comment: "")
    }

    func handle(text: String) {
        emptyView.isHidden = true
        didFetchPayload(text)
        codeView.set(code: text)
    }

    // MARK: EmptyViewDelegate

    func didTapRetry() {
        self.onRefresh()
    }

}
