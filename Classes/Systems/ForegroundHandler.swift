//
//  ForegroundHandler.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 8/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol ForegroundHandlerDelegate: class {
    func didForeground(handler: ForegroundHandler)
}

final class ForegroundHandler {

    weak var delegate: ForegroundHandlerDelegate? = nil

    private let threshold: CFTimeInterval
    private var backgrounded: CFTimeInterval = 0

    init(threshold: TimeInterval) {
        self.threshold = threshold

        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(ForegroundHandler.onForeground),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(ForegroundHandler.onBackground),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil
        )
    }

    // MARK: Private API

    @objc func onBackground() {
        backgrounded = CACurrentMediaTime()
    }

    @objc func onForeground() {
        if CACurrentMediaTime() - backgrounded > threshold {
            delegate?.didForeground(handler: self)
        }
    }

}
