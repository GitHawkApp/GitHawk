//
//  PageboyViewController+Transitioning.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 29/05/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

// MARK: - PageboyViewController transition configuration.
public extension PageboyViewController {
    
    /// Transition for a page scroll.
    public struct Transition {
        
        /// Style for the transition.
        ///
        /// - push: Slide the new page in (Default).
        /// - fade: Fade the new page in.
        /// - moveIn: Move the new page in over the top of the current page.
        /// - reveal: Reveal the new page under the current page.
        public enum Style: String {
            case push = "push"
            case fade = "fade"
            case moveIn = "moveIn"
            case reveal = "reveal"
        }
        
        /// The style for the transition.
        public let style: Style
        /// The duration of the transition.
        public let duration: TimeInterval
        
        /// Default transition (Push, 0.3 second duration).
        public static var defaultTransition: Transition {
            return Transition(style: .push, duration: 0.3)
        }
        
        // MARK: Init
        
        /// Initialize a transition.
        ///
        /// - Parameters:
        ///   - style: The style to use.
        ///   - duration: The duration to transition for.
        public init(style: Style, duration: TimeInterval) {
            self.style = style
            self.duration = duration
        }
    }
}

// MARK: - Custom PageboyViewController transitioning.
internal extension PageboyViewController {
    
    // MARK: Set Up
    
    fileprivate func prepareForTransition() {
        guard self.transitionDisplayLink == nil else { return }
        
        let transitionDisplayLink = CADisplayLink(target: self, selector: #selector(displayLinkDidTick))
        transitionDisplayLink.isPaused = true
        transitionDisplayLink.add(to: RunLoop.main, forMode: .commonModes)
        self.transitionDisplayLink = transitionDisplayLink
    }
    
    fileprivate func clearUpAfterTransition() {
        self.transitionDisplayLink?.invalidate()
        self.transitionDisplayLink = nil
    }
    
    // MARK: Animation
    
    @objc func displayLinkDidTick() {
        self.activeTransition?.tick()
    }
    
    /// Perform a transition to a new page index.
    ///
    /// - Parameters:
    ///   - from: The current index.
    ///   - to: The new index.
    ///   - direction: The direction of travel.
    ///   - animated: Whether to animate the transition.
    ///   - completion: Action on the completion of the transition.
    internal func performTransition(from: Int,
                                    to: Int,
                                    with direction: NavigationDirection,
                                    animated: Bool,
                                    completion: @escaping TransitionOperation.Completion) {
        guard animated == true else { return }
        guard self.activeTransition == nil else { return }
        guard let pageViewController = self.pageViewController else { return }
        
        prepareForTransition()
        
        /// Calculate semantic direction for RtL languages
        var semanticDirection = direction
        if view.layoutIsRightToLeft && navigationOrientation == .horizontal {
            semanticDirection = semanticDirection == .forward ? .reverse : .forward
        }
        
        // create a transition and unpause display link
        let action = TransitionOperation.Action(startIndex: from,
                                                endIndex: to,
                                                direction: direction,
                                                semanticDirection: semanticDirection,
                                                orientation: self.navigationOrientation)
        self.activeTransition = TransitionOperation(for: self.transition,
                                                    action: action,
                                                    delegate: self)
        self.transitionDisplayLink?.isPaused = false
        
        // start transition
        self.activeTransition?.start(on: pageViewController.view.layer,
                                     completion: completion)
    }
}

extension PageboyViewController: TransitionOperationDelegate {
    
    func transitionOperation(_ operation: TransitionOperation,
                             didFinish finished: Bool) {
        self.transitionDisplayLink?.isPaused = true
        self.activeTransition = nil
        
        clearUpAfterTransition()
    }
    
    func transitionOperation(_ operation: TransitionOperation,
                             didUpdateWith percentComplete: CGFloat) {
        
        let isReverse = operation.action.direction == .reverse
        let isVertical = operation.action.orientation == .vertical
        
        /// Take into account the diff between startIndex and endIndex
        let indexDiff = abs(operation.action.endIndex - operation.action.startIndex)
        let diff = percentComplete * CGFloat(indexDiff)
        
        let currentIndex = CGFloat(self.currentIndex ?? 0)
        let currentPosition = isReverse ? currentIndex - diff : currentIndex + diff
        let point = CGPoint(x: isVertical ? 0.0 : currentPosition,
                            y: isVertical ? currentPosition : 0.0)
        
        self.currentPosition = point
        self.delegate?.pageboyViewController(self, didScrollTo: point,
                                             direction: operation.action.direction,
                                             animated: true)
        self.previousPagePosition = currentPosition
    }
}

internal extension PageboyViewController.Transition {
    
    func configure(transition: inout CATransition) {
        transition.duration = self.duration
        transition.type = self.style.rawValue
    }
}
