//
//  NetworkActivityIndicatorManager.swift
//
//  Copyright (c) 2016-2018 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Alamofire
import Foundation
import UIKit

/// The `NetworkActivityIndicatorManager` manages the state of the network activity indicator in the status bar. When
/// enabled, it will listen for notifications indicating that a URL session task has started or completed and start
/// animating the indicator accordingly. The indicator will continue to animate while the internal activity count is
/// greater than zero.
///
/// To use the `NetworkActivityIndicatorManager`, the `shared` instance should be enabled in the
/// `application:didFinishLaunchingWithOptions:` method in the `AppDelegate`. This can be done with the following:
///
///     NetworkActivityIndicatorManager.shared.isEnabled = true
///
/// By setting the `isEnabled` property to `true` for the `shared` instance, the network activity indicator will show
/// and hide automatically as Alamofire requests start and complete. You should not ever need to call
/// `incrementActivityCount` and `decrementActivityCount` yourself.
public class NetworkActivityIndicatorManager {
    private enum ActivityIndicatorState {
        case notActive, delayingStart, active, delayingCompletion
    }

    // MARK: - Properties

    /// The shared network activity indicator manager for the system.
    public static let shared = NetworkActivityIndicatorManager()

    /// A boolean value indicating whether the manager is enabled. Defaults to `false`.
    public var isEnabled: Bool {
        get {
            lock.lock() ; defer { lock.unlock() }
            return enabled
        }
        set {
            lock.lock() ; defer { lock.unlock() }
            enabled = newValue
        }
    }

    /// A boolean value indicating whether the network activity indicator is currently visible.
    public private(set) var isNetworkActivityIndicatorVisible: Bool = false {
        didSet {
            guard isNetworkActivityIndicatorVisible != oldValue else { return }

            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.isNetworkActivityIndicatorVisible
                self.networkActivityIndicatorVisibilityChanged?(self.isNetworkActivityIndicatorVisible)
            }
        }
    }

    /// A closure executed when the network activity indicator visibility changes.
    public var networkActivityIndicatorVisibilityChanged: ((Bool) -> Void)?

    /// A time interval indicating the minimum duration of networking activity that should occur before the activity
    /// indicator is displayed. Defaults to `1.0` second.
    public var startDelay: TimeInterval = 1.0

    /// A time interval indicating the duration of time that no networking activity should be observed before dismissing
    /// the activity indicator. This allows the activity indicator to be continuously displayed between multiple network
    /// requests. Without this delay, the activity indicator tends to flicker. Defaults to `0.2` seconds.
    public var completionDelay: TimeInterval = 0.2

    private var activityIndicatorState: ActivityIndicatorState = .notActive {
        didSet {
            switch activityIndicatorState {
            case .notActive:
                isNetworkActivityIndicatorVisible = false
                invalidateStartDelayTimer()
                invalidateCompletionDelayTimer()
            case .delayingStart:
                scheduleStartDelayTimer()
            case .active:
                invalidateCompletionDelayTimer()
                isNetworkActivityIndicatorVisible = true
            case .delayingCompletion:
                scheduleCompletionDelayTimer()
            }
        }
    }

    private var activityCount: Int = 0
    private var enabled: Bool = true

    private var startDelayTimer: Timer?
    private var completionDelayTimer: Timer?

    private let lock = NSLock()

    // MARK: - Internal - Initialization

    init() {
        registerForNotifications()
    }

    deinit {
        unregisterForNotifications()

        invalidateStartDelayTimer()
        invalidateCompletionDelayTimer()
    }

    // MARK: - Activity Count

    /// Increments the number of active network requests.
    ///
    /// If this number was zero before incrementing, the network activity indicator will start spinning after
    /// the `startDelay`.
    ///
    /// Generally, this method should not need to be used directly.
    public func incrementActivityCount() {
        lock.lock() ; defer { lock.unlock() }

        activityCount += 1
        updateActivityIndicatorStateForNetworkActivityChange()
    }

    /// Decrements the number of active network requests.
    ///
    /// If the number of active requests is zero after calling this method, the network activity indicator will stop
    /// spinning after the `completionDelay`.
    ///
    /// Generally, this method should not need to be used directly.
    public func decrementActivityCount() {
        lock.lock() ; defer { lock.unlock() }

        activityCount -= 1
        updateActivityIndicatorStateForNetworkActivityChange()
    }

    // MARK: - Private - Activity Indicator State

    private func updateActivityIndicatorStateForNetworkActivityChange() {
        guard enabled else { return }

        switch activityIndicatorState {
        case .notActive:
            if activityCount > 0 { activityIndicatorState = .delayingStart }
        case .delayingStart:
            // No-op - let the delay timer finish
            break
        case .active:
            if activityCount == 0 { activityIndicatorState = .delayingCompletion }
        case .delayingCompletion:
            if activityCount > 0 { activityIndicatorState = .active }
        }
    }

    // MARK: - Private - Notification Registration

    private func registerForNotifications() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(NetworkActivityIndicatorManager.networkRequestDidStart),
            name: Notification.Name.Task.DidResume,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(NetworkActivityIndicatorManager.networkRequestDidComplete),
            name: Notification.Name.Task.DidSuspend,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(NetworkActivityIndicatorManager.networkRequestDidComplete),
            name: Notification.Name.Task.DidComplete,
            object: nil
        )
    }

    private func unregisterForNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private - Notifications

    @objc private func networkRequestDidStart() {
        incrementActivityCount()
    }

    @objc private func networkRequestDidComplete() {
        decrementActivityCount()
    }

    // MARK: - Private - Timers

    private func scheduleStartDelayTimer() {
        let timer = Timer(
            timeInterval: startDelay,
            target: self,
            selector: #selector(NetworkActivityIndicatorManager.startDelayTimerFired),
            userInfo: nil,
            repeats: false
        )

        DispatchQueue.main.async {
            #if swift(>=4.2)
            RunLoop.main.add(timer, forMode: .common)
            RunLoop.main.add(timer, forMode: .tracking)
            #else
            RunLoop.main.add(timer, forMode: .commonModes)
            RunLoop.main.add(timer, forMode: .UITrackingRunLoopMode)
            #endif
        }

        startDelayTimer = timer
    }

    private func scheduleCompletionDelayTimer() {
        let timer = Timer(
            timeInterval: completionDelay,
            target: self,
            selector: #selector(NetworkActivityIndicatorManager.completionDelayTimerFired),
            userInfo: nil,
            repeats: false
        )

        DispatchQueue.main.async {
            #if swift(>=4.2)
            RunLoop.main.add(timer, forMode: .common)
            RunLoop.main.add(timer, forMode: .tracking)
            #else
            RunLoop.main.add(timer, forMode: .commonModes)
            RunLoop.main.add(timer, forMode: .UITrackingRunLoopMode)
            #endif
        }

        completionDelayTimer = timer
    }

    @objc private func startDelayTimerFired() {
        lock.lock() ; defer { lock.unlock() }

        if activityCount > 0 {
            activityIndicatorState = .active
        } else {
            activityIndicatorState = .notActive
        }
    }

    @objc private func completionDelayTimerFired() {
        lock.lock() ; defer { lock.unlock() }
        activityIndicatorState = .notActive
    }

    private func invalidateStartDelayTimer() {
        startDelayTimer?.invalidate()
        startDelayTimer = nil
    }

    private func invalidateCompletionDelayTimer() {
        completionDelayTimer?.invalidate()
        completionDelayTimer = nil
    }
}
