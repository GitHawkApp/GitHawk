//
//  RepositoryCodeBlobViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class RepositoryCodeBlobViewController: UIViewController {

    private let client: GithubClient
    private let branch: String
    private let path: String
    private let repo: RepositoryDetails
    private let scrollView = UIScrollView()
    private let textView = UITextView()
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

    init(client: GithubClient, repo: RepositoryDetails, branch: String, path: String) {
        self.client = client
        self.repo = repo
        self.branch = branch
        self.path = path
        super.init(nibName: nil, bundle: nil)
        self.title = path
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        emptyView.isHidden = true
        view.addSubview(emptyView)

        scrollView.backgroundColor = .clear
        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)

        scrollView.refreshControl = feedRefresh.refreshControl
        feedRefresh.refreshControl.addTarget(self, action: #selector(RepositoryCodeBlobViewController.onRefresh), for: .valueChanged)

        textView.font = Styles.Fonts.code
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.contentInset = .zero
        textView.textContainerInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing,
            left: Styles.Sizes.columnSpacing,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.columnSpacing
        )
        scrollView.addSubview(textView)

        navigationItem.rightBarButtonItem = sharingButton

        fetch()
        feedRefresh.beginRefreshing()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let bounds = view.bounds
        emptyView.frame = bounds
        scrollView.frame = bounds
    }

    // MARK: Private API

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

        present(activityController, animated: true)
    }

    func fetch() {
        client.fetchFile(owner: repo.owner, repo: repo.name, branch: branch, path: path) { [weak self] (result) in
            self?.feedRefresh.endRefreshing()
            switch result {
            case .success(let text):
                self?.handle(text: text)
            case .nonUTF8:
                self?.error(cannotLoad: true)
            case .error:
                self?.error(cannotLoad: false)
                ToastManager.showGenericError()
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

        textView.text = text
        let max = CGFloat.greatestFiniteMagnitude
        let size = textView.sizeThatFits(CGSize(width: max, height: max))
        textView.frame = CGRect(origin: .zero, size: size)
        scrollView.contentSize = size
    }

}
