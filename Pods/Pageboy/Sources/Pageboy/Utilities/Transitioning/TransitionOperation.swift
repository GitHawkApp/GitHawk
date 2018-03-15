//
//  TransitionOperation.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 29/05/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal protocol TransitionOperationDelegate: class {
    
    /// A transition operation did finish.
    ///
    /// - Parameters:
    ///   - operation: The operation.
    ///   - finished: Whether it successfully finished.
    func transitionOperation(_ operation: TransitionOperation,
                             didFinish finished: Bool)
    
    /// A transition operation did progress.
    ///
    /// - Parameters:
    ///   - operation: The operation.
    ///   - percentComplete: The percent that the operation is complete.
    func transitionOperation(_ operation: TransitionOperation,
                             didUpdateWith percentComplete: CGFloat)
}

/// An operation for performing a PageboyViewController transition
internal class TransitionOperation: NSObject, CAAnimationDelegate {
    
    // MARK: Types
    
    /// Operation completion action.
    typealias Completion = (Bool) -> Void
    
    // MARK: Properties
    
    /// The transition for the operation.
    let transition: PageboyViewController.Transition
    /// The action that is occuring as part of the transition.
    let action: Action
    
    /// The raw animation for the operation.
    private var animation: CATransition?
    /// The time that the operation did start.
    private(set) var startTime: CFTimeInterval?
    
    /// Whether the operation is currently animating.
    private var isAnimating: Bool = false
    
    /// The object that acts as a delegate to the operation
    private(set) weak var delegate: TransitionOperationDelegate?
    /// Action to execute when the operation is complete.
    private var completion: Completion?
    
    /// The total duration of the transition.
    var duration: CFTimeInterval {
        guard let animation = self.animation else {
            return 0.0
        }
        return animation.duration
    }
    /// The percent that the transition is complete.
    var percentComplete: CGFloat {
        guard self.isAnimating else {
            return 0.0
        }
        
        let percent = CGFloat((CACurrentMediaTime() - (startTime ?? CACurrentMediaTime())) / duration)
        return max(0.0, min(1.0, percent))
    }
    
    // MARK: Init
    
    init(for transition: PageboyViewController.Transition,
         action: Action,
         delegate: TransitionOperationDelegate) {
        self.transition = transition
        self.action = action
        self.delegate = delegate
        
        var animation = CATransition()
        animation.startProgress = 0.0
        animation.endProgress = 1.0
        transition.configure(transition: &animation)
        animation.subtype = action.transitionSubType
        animation.fillMode = kCAFillModeBackwards
        self.animation = animation
        
        super.init()
        
        animation.delegate = self
    }
    
    // MARK: Transitioning
    
    /// Start the transition animation on a layer.
    ///
    /// - Parameter layer: The layer to animate.
    /// - Parameter completion: Completion of the transition.
    func start(on layer: CALayer,
               completion: @escaping Completion) {
        guard let animation = self.animation else {
            completion(false)
            return
        }
        
        self.completion = completion
        self.startTime = CACurrentMediaTime()
        layer.add(animation,
                  forKey: "transition")
    }
    
    /// Perform a frame tick on the transition.
    func tick() {
        guard isAnimating else {
            return
        }
        delegate?.transitionOperation(self, didUpdateWith: percentComplete)
    }
    
    // MARK: CAAnimationDelegate
    
    public func animationDidStart(_ anim: CAAnimation) {
        isAnimating = true
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isAnimating = false
        completion?(flag)
        delegate?.transitionOperation(self, didFinish: flag)
        self.animation = nil
    }
}
