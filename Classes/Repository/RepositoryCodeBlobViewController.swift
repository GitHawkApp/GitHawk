//
//  RepositoryCodeBlobViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Squawk
import TUSafariActivity

final class RepositoryCodeBlobViewController: UIViewController, EmptyViewDelegate {

    private let client: GithubClient
    private let branch: String
    private let path: FilePath
    private let repo: RepositoryDetails
    private let codeView = CodeView()
    private let feedRefresh = FeedRefresh()
    private let emptyView = EmptyView()
    private var sharingPayload: Any?
    private var repoUrl: URL {
        return URL(string: "https://github.com/\(repo.owner)/\(repo.name)/blob/\(branch)/\(path.path)")!
    }

    private lazy var moreOptionsItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
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

        navigationItem.rightBarButtonItem = moreOptionsItem

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
        moreOptionsItem.isEnabled = true
    }

    @objc func onRefresh() {
        fetch()
    }

    @objc func onShare(sender: UIButton) {
        let alertTitle = "\(repo.owner)/\(repo.name):\(branch)"
        let alert = UIAlertController.configured(title: alertTitle, preferredStyle: .actionSheet)

        weak var weakSelf = self
        let alertBuilder = AlertActionBuilder { $0.rootViewController = weakSelf }
        var actions = [
            viewHistoryAction(owner: repo.owner, repo: repo.name, branch: branch, client: client, path: path),
            AlertAction(alertBuilder).share([path.path], activities: nil, type: .shareFilePath) {
                $0.popoverPresentationController?.setSourceView(sender)
            },
            AlertAction(alertBuilder).share([repoUrl], activities: [TUSafariActivity()], type: .shareUrl) {
                $0.popoverPresentationController?.setSourceView(sender)
            },
            AlertAction.cancel()
        ]

        if let name = self.path.components.last {
            actions.insert(AlertAction(alertBuilder).share([name], activities: nil, type: .shareFileName) {
                $0.popoverPresentationController?.setSourceView(sender)
            }, at: 1)
        }
        if let payload = self.sharingPayload {
            actions.insert(AlertAction(alertBuilder).share([payload], activities: nil, type: .shareContent) {
                $0.popoverPresentationController?.setSourceView(sender)
            }, at: actions.endIndex - 1)
        }

        alert.addActions(actions)
        alert.popoverPresentationController?.setSourceView(sender)
        present(alert, animated: trueUnlessReduceMotionEnabled)
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
            case .error(let error):
                self?.error(cannotLoad: false)
                Squawk.show(error: error)
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
