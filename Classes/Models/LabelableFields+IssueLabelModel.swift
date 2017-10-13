//
//  LabelableFields+IssueLabelModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension LabelableFields {

    var issueLabelModels: [RepositoryLabel] {
        var models = [RepositoryLabel]()
        for node in labels?.nodes ?? [] {
            guard let node = node else { continue }
            models.append(RepositoryLabel(color: node.color, name: node.name))
        }
        return models
    }

}
