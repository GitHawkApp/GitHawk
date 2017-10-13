//
//  RepositoryCodeDirectoryViewController.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class RepositoryCodeDirectoryViewController: UITableViewController {

    private let path: String
    private let cellIdentifier = "cell"
    private let feedRefresh = FeedRefresh()
    private var files = [RepositoryFile]()

    init(path: String) {
        self.path = path
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        files = [
            RepositoryFile(name: "Classes", isDirectory: true),
            RepositoryFile(name: "Tests", isDirectory: true),
            RepositoryFile(name: "GitHawk.xcodeproj", isDirectory: true),
            RepositoryFile(name: "LICENSE", isDirectory: false),
            RepositoryFile(name: "README.md", isDirectory: false),
            RepositoryFile(name: "Podfile", isDirectory: false),
        ]

        makeBackBarItemEmpty()

        feedRefresh.refreshControl.addTarget(
            self,
            action: #selector(RepositoryCodeDirectoryViewController.onRefresh),
            for: .valueChanged
        )
        tableView.refreshControl = feedRefresh.refreshControl
        tableView.register(StyledTableCell.self, forCellReuseIdentifier: cellIdentifier)

        feedRefresh.beginRefreshing()
        fetch()
    }

    // MARK: Private API

    func fetch() {
        feedRefresh.endRefreshing()
    }

    @objc
    func onRefresh() {
        feedRefresh.endRefreshing()
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let file = files[indexPath.row]
        cell.textLabel?.text = file.name

        let imageName = file.isDirectory ? "file-directory" : "file"
        cell.imageView?.image = UIImage(named: imageName)
        cell.accessoryType = file.isDirectory ? .disclosureIndicator : .none

        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // TODO: push another controller
    }

}
