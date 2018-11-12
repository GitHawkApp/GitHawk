//
//  SpecialGitHubEmoji.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

enum SpecialGitHubEmoji: String {
    
    case feelsgood
    case finnadie
    case goberserk
    case godmode
    case hurtrealbad
    case neckbeard
    case octocat
    case rage1
    case rage2
    case rage3
    case rage4
    case shipit
    case suspect
    case trollface

    static let regex: NSRegularExpression = {
        let all: [SpecialGitHubEmoji] = [
            .feelsgood,
            .finnadie,
            .goberserk,
            .godmode,
            .hurtrealbad,
            .neckbeard,
            .octocat,
            .rage1,
            .rage2,
            .rage3,
            .rage4,
            .shipit,
            .suspect,
            .trollface
        ]
        let pattern = "(" + all.map({ ":\($0.rawValue):" }).joined(separator: "|") + ")"
        return try! NSRegularExpression(pattern: pattern, options: [])
    }()

    var image: UIImage? {
        return UIImage(named: rawValue)
    }

}
