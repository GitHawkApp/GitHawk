//
//  Announcer.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

final class Announcer<T> {

    private class Wrapper {
        weak var listener: AnyObject?
        init(listener: AnyObject) {
            self.listener = listener
        }
    }

    private var wrappers = [Wrapper]()

    func add(listener: T) {
        wrappers.append(Wrapper(listener: listener as AnyObject))
    }

    func enumerate(with block: (T) -> Void) {
        var deadIndices = [Int]()
        for (i, wrapper) in wrappers.enumerated() {
            if let listener = wrapper.listener as? T {
                block(listener)
            } else {
                deadIndices.append(i)
            }
        }
        deadIndices.reversed().forEach { wrappers.remove(at: $0) }
    }

}
