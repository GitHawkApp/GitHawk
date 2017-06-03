//
//  LabelableFields+IssueLabelModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension LabelableFields {

    var issueLabelModels: [IssueLabelModel] {
        var models = [IssueLabelModel]()
        for node in labels?.nodes ?? [] {
            guard let node = node else { continue }
            models.append(IssueLabelModel(color: node.color, name: node.name))
        }
        return models
    }

}
