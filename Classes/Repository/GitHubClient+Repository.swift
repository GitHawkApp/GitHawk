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
        fetch(query: query) { (result, error) in
            if let models = result?.data?.repository?.object?.asTree?.entries {
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
            } else {
                completion(.error(nil))
            }
        }
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
        fetch(query: query) { (result, error) in
            if let blob = result?.data?.repository?.object?.asBlob {
                if let text = blob.text, !text.isEmpty {
                    completion(.success(text))
                } else {
                    completion(.nonUTF8)
                }
            } else {
                completion(.error(error))
            }
        }
    }

}
