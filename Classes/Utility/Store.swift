//
//  Store.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol Store {
    associatedtype Model: Codable, Equatable

    var key: String { get }
    var defaults: UserDefaults { get }

    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }

    var values: [Model] { get set }

    mutating func add(_ value: Model)
    mutating func remove(_ value: Model)
    mutating func clear()
    func save()
}

extension Store {
    mutating func add(_ value: Model) {
        guard !values.contains(value) else { return }
        values.insert(value, at: 0)
    }

    mutating func remove(_ value: Model) {
        guard let offset = values.index(of: value) else { return }
        let index = values.startIndex.distance(to: offset)
        values.remove(at: index)
        save()
    }

    mutating func clear() {
        values.removeAll()
        save()
    }

    func save() {
        guard let data = try? encoder.encode(values) else { return }
        defaults.set(data, forKey: key)
    }
}
