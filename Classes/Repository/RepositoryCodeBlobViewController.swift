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
    private let path: String
    private let repo: RepositoryDetails
    private let scrollView = UIScrollView()
    private let textView = UITextView()
    private let feedRefresh = FeedRefresh()

    init(client: GithubClient, repo: RepositoryDetails, path: String) {
        self.client = client
        self.repo = repo
        self.path = path
        super.init(nibName: nil, bundle: nil)
        self.title = path
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.backgroundColor = .white
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

        fetch()
        feedRefresh.beginRefreshing()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
    }

    // MARK: Private API

    @objc
    func onRefresh() {
        fetch()
    }

    func fetch() {
        client.fetchFile(owner: repo.owner, repo: repo.name, path: path) { [weak self] (result) in
            self?.feedRefresh.endRefreshing()
            switch result {
            case .success(let text):
                self?.handle(text: text)
            case .nonUTF8:
                ToastManager.showError(message: NSLocalizedString("Cannot load file type.", comment: ""))
            case .error:
                ToastManager.showGenericError()
            }
        }
    }

    func handle(text: String) {
        textView.text = text
        let max = CGFloat.greatestFiniteMagnitude
        let size = textView.sizeThatFits(CGSize(width: max, height: max))
        textView.frame = CGRect(origin: .zero, size: size)
        scrollView.contentSize = size
    }

}
