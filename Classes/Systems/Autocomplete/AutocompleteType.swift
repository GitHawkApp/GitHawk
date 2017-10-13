//
//  AutocompleteType.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol AutocompleteType {

    var prefix: String { get }

    var resultsCount: Int { get }

    func configure(cell: AutocompleteCell, index: Int)

    func search(word: String, completion: @escaping (Bool) -> ())

    func accept(index: Int) -> String?

}
