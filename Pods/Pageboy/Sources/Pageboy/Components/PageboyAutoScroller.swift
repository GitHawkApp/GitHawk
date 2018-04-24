//
//  PageboyAutoScroller.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 08/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

/// Internal protocol for handling auto scroller events.
internal protocol PageboyAutoScrollerHandler: class {
    
    /// Auto scroller requires a scroll.
    ///
    /// - Parameter autoScroller: The auto scroller.
    /// - Parameter animated: Whether the scroll should be animated.
    func autoScroller(didRequestAutoScroll autoScroller: PageboyAutoScroller, animated: Bool)
}

/// Delegate protocol for observing auto scroll events.
public protocol PageboyAutoScrollerDelegate: class {
    
    /// The auto scroller will begin a scroll animation on the page view controller.
    ///
    /// - Parameter autoScroller: The auto scroller.
    func autoScroller(willBeginScrollAnimation autoScroller: PageboyAutoScroller)
    
    /// The auto scroller did finish a scroll animation on the page view controller.
    ///
    /// - Parameter autoScroller: The auto scroller.
    func autoScroller(didFinishScrollAnimation autoScroller: PageboyAutoScroller)
}

/// Object that provides auto scrolling framework to PageboyViewController
public class PageboyAutoScroller: Any {
    
    // MARK: Types
    
    /// Duration spent on each page.
    ///
    /// - short: Short (5 seconds)
    /// - long: Long (10 seconds)
    /// - custom: Custom duration
    public enum IntermissionDuration {
        case short
        case long
        case custom(duration: TimeInterval)
    }
    
    // MARK: Properties
    
    /// The timer
    fileprivate var timer: Timer?
    
    /// Whether the auto scroller is enabled.
    public private(set) var isEnabled: Bool = false
    /// Whether the auto scroller was enabled previous to a cancel event
    internal var wasEnabled: Bool?
    /// Whether a scroll animation is currently active.
    internal fileprivate(set) var isScrolling: Bool?
    
    /// The object that acts as a handler for auto scroll events.
    internal weak var handler: PageboyAutoScrollerHandler?
    
    /// The duration spent on each page during auto scrolling. Default: .short
    public private(set) var intermissionDuration: IntermissionDuration = .short
    /// Whether auto scrolling is disabled on drag of the page view controller.
    public var cancelsOnScroll: Bool = true
    /// Whether auto scrolling restarts when a page view controller scroll ends.
    public var restartsOnScrollEnd: Bool = false
    /// Whether the auto scrolling transitions should be animated.
    public var animateScroll: Bool = true
    
    /// The object that acts as a delegate to the auto scroller.
    public weak var delegate: PageboyAutoScrollerDelegate?

    // MARK: State
    
    /// Enable auto scrolling behaviour.
    ///
    /// - Parameter duration: The duration that should be spent on each page.
    public func enable(withIntermissionDuration duration: IntermissionDuration? = nil) {
        guard !self.isEnabled else {
            return
        }
        
        if let duration = duration {
            self.intermissionDuration = duration
        }
        
        self.isEnabled = true
        self.createTimer(withDuration: self.intermissionDuration.rawValue)
    }
    
    /// Disable auto scrolling behaviour
    public func disable() {
        guard self.isEnabled else {
            return
        }
        
        self.destroyTimer()
        self.isEnabled = false
    }
    
    /// Cancel the current auto scrolling behaviour.
    internal func cancel() {
        guard self.isEnabled else {
            return
        }
        self.wasEnabled = true
        self.disable()
    }
    
    /// Restart auto scrolling behaviour if it was previously cancelled.
    internal func restart() {
        guard self.wasEnabled == true && !self.isEnabled else {
            return
        }
        
        self.wasEnabled = nil
        self.enable()
    }
}

// MARK: - Intervals
internal extension PageboyAutoScroller.IntermissionDuration {
    var rawValue: TimeInterval {
        switch self {
        case .short:
            return 5.0
        case .long:
            return 10.0
        case .custom(let duration):
            return duration
        }
    }
}

// MARK: - Timer
internal extension PageboyAutoScroller {
    
    /// Initialize auto scrolling timer
    ///
    /// - Parameter duration: The duration for the timer.
    func createTimer(withDuration duration: TimeInterval) {
        guard self.timer == nil else {
            return
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: duration,
                                          target: self,
                                          selector: #selector(timerDidElapse(_:)),
                                          userInfo: nil, repeats: true)
    }
    
    /// Remove auto scrolling timer
    func destroyTimer() {
        guard self.timer != nil else {
            return
        }
        
        self.timer?.invalidate()
        self.timer = nil
    }
    
    /// Called when a scroll animation is finished
    func didFinishScrollIfEnabled() {
        guard self.isScrolling == true else {
            return
        }
        
        self.isScrolling = nil
        self.delegate?.autoScroller(didFinishScrollAnimation: self)
    }
    
    @objc func timerDidElapse(_ timer: Timer) {
        self.isScrolling = true
        self.delegate?.autoScroller(willBeginScrollAnimation: self)
        self.handler?.autoScroller(didRequestAutoScroll: self, animated: self.animateScroll)
    }
}
