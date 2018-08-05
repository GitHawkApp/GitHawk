//
//  SquawkItem.swift
//  Squawk
//
//  Created by Ryan Nystrom on 7/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

internal final class SquawkItem: SquawkViewDelegate {

    let view: SquawkView
    let animator: UIDynamicAnimator
    let springBehavior: UIAttachmentBehavior
    let configuration: Squawk.Configuration

    private var timer: Timer?

    init(config: Squawk.Configuration, in baseView: UIView) {
        configuration = config

        view = SquawkView(configuration: config)
        view.frame = CGRect(origin: .zero, size: view.contentSize())
        baseView.addSubview(view)

        animator = UIDynamicAnimator(referenceView: baseView)

        let initAnchor = anchor(view: view, referenceView: baseView, configuration: configuration)

        // position off screen so it snaps in. must happen before setting up spring
        view.center = initAnchor.applying(CGAffineTransform(
            translationX: 0,
            y: baseView.bounds.height - initAnchor.y
        ))

        springBehavior = UIAttachmentBehavior(item: view, attachedToAnchor: initAnchor)
        springBehavior.length = 0
        springBehavior.damping = 0.9
        springBehavior.frequency = 2

        // use UIView animations to avoid annoying oscillation from behavior
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.1,
            options: [],
            animations: {
                self.view.center = initAnchor
        }) { _ in
            guard self.view.superview != nil else { return }
            self.animator.addBehavior(self.springBehavior)
        }

        view.delegate = self
    }

    // MARK: Public API

    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: configuration.dismissDuration,
            repeats: false,
            block: { [weak self] (_) in
                self?.dismiss()
        })
    }

    func dismiss(completion: (() -> Void)? = nil) {
        invalidateTimer()
        animator.removeBehavior(springBehavior)

        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.alpha = 0
            self.view.center = self.dismissAnchor
        }, completion: { _ in
            self.view.removeFromSuperview()
            completion?()
        })
    }

    func recenter() {
        // UIDynamics will throw if adding the behavior back when the view has already been removed
        guard view.superview != nil,
            let referenceView = animator.referenceView
            else { return }

        // hack to work around UI bug where behavior will permanently oscillate
        animator.removeBehavior(springBehavior)
        springBehavior.anchorPoint = anchor(view: view, referenceView: referenceView, configuration: configuration)
        animator.addBehavior(springBehavior)
    }

    // MARK: Private API

    private var dismissAnchor: CGPoint {
        guard let referenceView = animator.referenceView else { return .zero }
        return CGPoint(
            x: referenceView.bounds.width / 2,
            y: referenceView.bounds.height + view.bounds.height / 2 + 100
        )
    }

    // MARK: SquawkViewDelegate

    func didTapInfo(for view: SquawkView) {
        configuration.buttonTapHandler?()
    }

}
