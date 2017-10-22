//
//  Debouncer.swift
//  Freetime
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

class Debouncer {
    private let delay: Double
    private weak var timer: Timer?

    var action: (() -> Void)? {
        didSet {
            debounce()
        }
    }

    init(delay: Double = 0.35) {
        self.delay = delay
    }

    convenience init(delay: Double = 0.35, action: @escaping (() -> Void)) {
        self.init(delay: delay)
        self.action = action
    }

    func cancel() {
        timer?.invalidate()
    }

    private func debounce() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: delay,
            target: self,
            selector: #selector(Debouncer.executeAction(_:)),
            userInfo: nil,
            repeats: false
        )
    }

    @objc private func executeAction(_ sender: Timer) {
        action?()
    }
}
