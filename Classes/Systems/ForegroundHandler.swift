//
//  ForegroundHandler.swift
//  Freetime
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
    private var backgrounded: CFTimeInterval? = nil

    init(threshold: TimeInterval) {
        self.threshold = threshold

        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(ForegroundHandler.didBecomeActive),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(ForegroundHandler.willResignActive),
            name: NSNotification.Name.UIApplicationWillResignActive,
            object: nil
        )
    }

    // MARK: Private API

    @objc func willResignActive() {
        backgrounded = CACurrentMediaTime()
    }

    @objc func didBecomeActive() {
        guard let backgrounded = self.backgrounded else { return }
        self.backgrounded = nil
        if CACurrentMediaTime() - backgrounded > threshold {
            delegate?.didForeground(handler: self)
        }
    }

}
