//
//  RepositoryCodeDirectoryViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class RepositoryCodeDirectoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let client: GithubClient
    private let path: String
    private let repo: RepositoryDetails
    private let cellIdentifier = "cell"
    private let feedRefresh = FeedRefresh()
    private var files = [RepositoryFile]()
    private let isRoot: Bool

    init(client: GithubClient, repo: RepositoryDetails, path: String, isRoot: Bool) {
        self.client = client
        self.repo = repo
        self.path = path
        self.isRoot = isRoot
        super.init(nibName: nil, bundle: nil)
        self.title = isRoot
        ? NSLocalizedString("Code", comment: "")
        : path
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        // set the frame in -viewDidLoad is required when working with TabMan
        tableView.frame = view.bounds
        if isRoot, #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }

        makeBackBarItemEmpty()

        feedRefresh.refreshControl.addTarget(
            self,
            action: #selector(RepositoryCodeDirectoryViewController.onRefresh),
            for: .valueChanged
        )
        tableView.refreshControl = feedRefresh.refreshControl
        tableView.register(StyledTableCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0.1))

        feedRefresh.beginRefreshing()
        fetch()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(tableView: tableView)
    }

    // MARK: Private API

    func fetch() {
        client.fetchFiles(owner: repo.owner, repo: repo.name, path: path) { [weak self] (result) in
            switch result {
            case .error:
                ToastManager.showGenericError()
            case .success(let files):
                self?.files = files
                self?.tableView.reloadData()
                self?.feedRefresh.endRefreshing()
            }
        }
    }

    @objc
    func onRefresh() {
        fetch()
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StyledTableCell

        let file = files[indexPath.row]
        cell.setup(with: file)

        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = files[indexPath.row]
        let newPath = path.isEmpty ? file.name : "\(path)/\(file.name)"

        let controller: UIViewController
        if file.isDirectory {
            controller = RepositoryCodeDirectoryViewController(
                client: client,
                repo: repo,
                path: newPath,
                isRoot: false
            )
        } else {
            controller = RepositoryCodeBlobViewController(client: client, repo: repo, path: newPath)
        }
        navigationController?.pushViewController(controller, animated: true)
    }

}
