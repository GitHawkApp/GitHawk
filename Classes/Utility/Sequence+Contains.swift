//
//  Sequence+Contains.swift
//  Freetime
//
//  Created by Bas Broek on 03/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Sequence where Element: Equatable {

    /// Returns a Boolean value indicating whether every element of the sequence
    /// is equal to the given element.
    func containsAll(_ element: Element) -> Bool {
        var iterator = self.makeIterator()
        guard iterator.next() != nil else { return false }
        return first(where: { $0 != element }) == nil
    }

    /// Returns a Boolean value indicating whether every element of the sequence
    /// does not equal to the given element.
    func containsNone(_ element: Element) -> Bool {
        return first(where: { $0 == element }) == nil
    }
}

extension Sequence {

    /// Returns a Boolean value indicating whether every element of the sequence
    /// satisfies the given predicate.
    func containsAll(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        var iterator = self.makeIterator()
        var isNotEmpty = false

        while let element = iterator.next() {
            isNotEmpty = true
            if try !predicate(element) {
                return false
            }
        }
        return isNotEmpty
    }

    /// Returns a Boolean value indicating whether every element of the sequence
    /// does not satisfies the given predicate.
    func containsNone(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        var iterator = self.makeIterator()

        while let element = iterator.next() {
            if try predicate(element) {
                return false
            }
        }
        return true
    }
}
