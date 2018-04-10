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

    weak var delegate: ForegroundHandlerDelegate?

    private let threshold: CFTimeInterval
    private var backgrounded: CFTimeInterval?

    init(threshold: TimeInterval) {
        self.threshold = threshold

        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: .UIApplicationDidBecomeActive,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(willResignActive),
            name: .UIApplicationWillResignActive,
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
            // there seems to be a bug where refreshing while still becoming active messes up the iOS 11 header and
            // refresh control. put an artificial delay to let the system cool down?
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.delegate?.didForeground(handler: self)
            })
        }
    }

}
