//
//  GitHubClient+Repository.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    func fetchFiles(
        owner: String,
        repo: String,
        branch: String,
        path: String,
        completion: @escaping (Result<[RepositoryFile]>) -> Void
        ) {
        let query = RepoFilesQuery(owner: owner, name: repo, branchAndPath: "\(branch):\(path)")

        client.query(query, result: { $0.repository?.object?.asTree?.entries }, completion: { result in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let models):
                // trees A-Z first, then blobs A-Z
                var trees = [RepositoryFile]()
                var blobs = [RepositoryFile]()
                for model in models {
                    let isTree = model.type == "tree"
                    let file = RepositoryFile(
                        name: model.name,
                        isDirectory: model.type == "tree"
                    )
                    if isTree {
                        trees.append(file)
                    } else {
                        blobs.append(file)
                    }
                }
                trees.sort { $0.name < $1.name }
                blobs.sort { $0.name < $1.name }
                completion(.success(trees + blobs))
            }
        })
    }

    // different result type so handling non-text is treated differently
    enum FileResult {
        case success(String)
        case nonUTF8
        case error(Error?)
    }

    func fetchFile(
        owner: String,
        repo: String,
        branch: String,
        path: String,
        completion: @escaping (FileResult) -> Void
        ) {
        let query = RepoFileQuery(owner: owner, name: repo, branchAndPath: "\(branch):\(path)")
        client.query(query, result: { $0.repository?.object?.asBlob }, completion: { result in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let blob):
                if let text = blob.text, !text.isEmpty {
                    completion(.success(text))
                } else {
                    completion(.nonUTF8)
                }
            }
        })
    }

}
