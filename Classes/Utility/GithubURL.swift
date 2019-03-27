//
//  GithubURL.swift
//  Freetime
//
//  Created by Viktoras Laukevicius on 20/02/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

enum GithubURL {
    static func codeBlob(repo: RepositoryDetails, branch: String, path: FilePath) -> URL? {
        let builder = URLBuilder.github()
            .add(path: repo.owner)
            .add(path: repo.name)
            .add(path: "blob")
            .add(path: branch)
        path.components.forEach { builder.add(path: $0) }
        return builder.url
    }
}
