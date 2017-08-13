//
//  IssueFileContentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssueFileContentViewController: UIViewController {

    private let fullPath: String
    private let client: GithubClient
    private let scrollView = UIScrollView()
    private let attributeView = AttributedStringView()
    private let feedRefresh = FeedRefresh()
    private var result: GithubClient.ContentResult? = nil

    init(fullPath: String, client: GithubClient) {
        self.fullPath = fullPath
        self.client = client
        super.init(nibName: nil, bundle: nil)

        scrollView.refreshControl = feedRefresh.refreshControl
        feedRefresh.refreshControl.addTarget(self, action: #selector(IssueFileContentViewController.onRefresh), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)

        scrollView.addSubview(attributeView)

        feedRefresh.beginRefreshing()
        fetch()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
    }

    // MARK: Private API

    func onRefresh() {
        fetch()
    }

    func fetch() {
        client.fetchContents(contentsURLString: fullPath) { [weak self] (result) in
            self?.handle(result: result)
        }
    }

    func handle(result: GithubClient.ContentResult) {
        feedRefresh.endRefreshing()

        self.result = result
        switch result {
        case .success(let text, let content):
            title = content.name

            let width: CGFloat = 0
            scrollView.contentSize = text.textViewSize(width)
            attributeView.configureAndSizeToFit(text: text, width: width)
        case .error: break
        }
    }

}
