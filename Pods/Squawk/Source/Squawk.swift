//
//  Squawk.swift
//  Squawk
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public class Squawk {

    private var activeItem: SquawkItem?

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Squawk.onOrientation(notification:)),
            name: .UIDeviceOrientationDidChange,
            object: nil
        )
    }

    // MARK: Public API

    public static let shared = Squawk()

    public func show(
        in view: UIView? = UIApplication.shared.keyWindow,
        config: Squawk.Configuration
        ) {
        guard let baseView = view else { return }

        // get rid of any view if currently displaying
        activeItem?.dismiss()

        let item = SquawkItem(config: config, in: baseView)
        activeItem = item

        item.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPan(gesture:))))
        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, item.configuration.text)
        item.startTimer()
    }

    public func dismiss(completion: (() -> Void)? = nil) {
        activeItem?.dismiss(completion: completion)
        activeItem = nil
    }

    // MARK: Private API

    @objc func onPan(gesture: UIPanGestureRecognizer) {
        guard let activeItem = self.activeItem,
            let referenceView = activeItem.animator.referenceView
            else { return }

        switch gesture.state {
        case .began:
            activeItem.invalidateTimer()
            activeItem.animator.removeBehavior(activeItem.springBehavior)
        case .changed:
            let anchor = activeItem.springBehavior.anchorPoint
            let translation = gesture.translation(in: referenceView).y

            let y: CGFloat
            if translation < 0 {
                let unboundedY = anchor.y + translation
                y = rubberBandDistance(
                    offset: unboundedY - anchor.y,
                    dimension: referenceView.bounds.height - anchor.y
                )
            } else {
                y = translation
            }
            activeItem.view.center = CGPoint(
                x: anchor.x,
                y: y + anchor.y
            )
        case .ended, .cancelled, .failed:
            let velocity = gesture.velocity(in: referenceView).y

            // if the final destination is beyond the ref view height after 0.3 seconds...
            let duration: TimeInterval = 0.3
            let finalY = velocity * CGFloat(duration) + activeItem.view.center.y
            if finalY - activeItem.view.bounds.height / 2 > referenceView.bounds.height {
                UIView.animate(withDuration: duration, animations: {
                    var center = activeItem.view.center
                    center.y = finalY
                    activeItem.view.center = center
                }) { _ in
                    activeItem.view.removeFromSuperview()
                }
            } else {
                activeItem.startTimer()
                activeItem.animator.addBehavior(activeItem.springBehavior)
            }
        default: break
        }
    }

    @objc func onOrientation(notification: NSNotification) {
        activeItem?.recenter()
    }

}
