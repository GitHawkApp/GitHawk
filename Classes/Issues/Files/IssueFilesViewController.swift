//
//  IssueFilesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssueFilesViewController: UITableViewController {

    private var model: IssueDetailsModel!
    private var client: GithubClient!
    private var result: Result<[File]>? = nil
    private let feedRefresh = FeedRefresh()

    override func viewDidLoad() {
        super.viewDidLoad()

        makeBackBarItemEmpty()

        feedRefresh.refreshControl.addTarget(self, action: #selector(IssueFilesViewController.onRefresh), for: .valueChanged)
        tableView.refreshControl = feedRefresh.refreshControl

        feedRefresh.beginRefreshing()
        fetch()
    }

    // MARK: Public API

    func configure(model: IssueDetailsModel, client: GithubClient) {
        self.model = model
        self.client = client
    }

    // MARK: Private API

    @objc
    func onRefresh() {
        fetch()
    }

    func fetch() {
        client.fetchFiles(
        owner: model.owner,
        repo: model.repo,
        number: model.number) { [weak self] (result) in
            self?.handle(result: result)
        }
    }

    func handle(result: Result<[File]>) {
        self.result = result
        tableView.reloadData()
        feedRefresh.endRefreshing()

        switch result {
        case .success(let files):
            let titleFormat = NSLocalizedString("Files (%zi)", comment: "")
            title = String.localizedStringWithFormat(titleFormat, files.count)
        default: break
        }
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = self.result else { return 0 }
        switch result {
        case .success(let files): return files.count
        case .error: return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = self.result else { fatalError("No cells when no data") }

        let identifier: String
        var file: File? = nil
        switch result {
        case .success(let files):
            identifier = "file"
            file = files[indexPath.row]
        case .error:
            identifier = "error"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = cell as? IssueFilesTableCell, let file = file {
            cell.configure(path: file.filename, additions: file.additions.intValue, deletions: file.deletions.intValue)
        }

        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let result = result else { return }

        switch result {
        case .success(let files):
            let controller = IssuePatchContentViewController(file: files[indexPath.row], client: client)
            show(controller, sender: nil)
        default: break
        }
    }

}
