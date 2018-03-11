//
//  ContextMenuPresentationController.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol ContextMenuPresentationControllerDelegate: class {
    func willDismiss(presentationController: ContextMenuPresentationController)
}

class ContextMenuPresentationController: UIPresentationController {

    weak var contextDelegate: ContextMenuPresentationControllerDelegate?
    let item: ContextMenu.Item

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, item: ContextMenu.Item) {
        self.item = item
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = item.options.containerStyle.overlayColor
        return view
    }()

    var preferredSourceViewCorner: SourceViewCorner? {
        guard let sourceViewFrame = item.sourceView?.frame,
            let containerView = self.containerView,
            let frame = item.sourceView?.superview?.convert(sourceViewFrame, to: containerView)
            else { return nil}

        let corners: [SourceViewCorner] = [
            SourceViewCorner(point: CGPoint(x: frame.minX, y: frame.minY), position: .topLeft),
            SourceViewCorner(point: CGPoint(x: frame.maxX, y: frame.minY), position: .topRight),
            SourceViewCorner(point: CGPoint(x: frame.minX, y: frame.maxY), position: .bottomLeft),
            SourceViewCorner(point: CGPoint(x: frame.maxX, y: frame.maxY), position: .bottomRight),
            ]

        var maxArea: CGFloat = 0
        var maxCorner: SourceViewCorner? = nil
        for corner in corners {
            let area = containerView.bounds.area(corner: corner)
            if area > maxArea {
                maxArea = area
                maxCorner = corner
            }
        }
        return maxCorner
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerBounds = containerView?.bounds else { return .zero }
        let size = presentedViewController.preferredContentSize
        if let corner = preferredSourceViewCorner {
            let minPadding = item.options.containerStyle.edgePadding
            let x = corner.point.x
                + corner.position.xSizeModifier * size.width
                + corner.position.xModifier * item.options.containerStyle.xPadding
            let y = corner.point.y
                + corner.position.ySizeModifier * size.height
                + corner.position.yModifier * item.options.containerStyle.yPadding
            return CGRect(
                x: max(minPadding, min(containerBounds.width - size.width - minPadding, x)),
                y: max(minPadding, min(containerBounds.height - size.height - minPadding, y)),
                width: size.width,
                height: size.height
            )
        } else {
            return CGRect(
                x: (containerBounds.width - size.width)/2,
                y: (containerBounds.height - size.height)/2,
                width: size.width,
                height: size.height
            )
        }
    }

    override func containerViewWillLayoutSubviews() {
        guard let containerView = self.containerView else { return }
        let frame = frameOfPresentedViewInContainerView
        if frame != .zero {
            presentedView?.frame = frame
        }
        overlayView.frame = containerView.bounds
    }

    var presentedViewTransform: CATransform3D {
        let translate: CATransform3D
        if let corner = preferredSourceViewCorner {
            let frame = frameOfPresentedViewInContainerView
            let center = CGPoint(x: frame.minX + frame.width / 2, y: frame.minY + frame.height / 2)
            translate = CATransform3DMakeTranslation(corner.point.x - center.x, corner.point.y - center.y, 0)
        } else {
            translate = CATransform3DIdentity
        }
        let scale: CGFloat = item.sourceView == nil ? 0.8 : 0.2
        return CATransform3DScale(translate, scale, scale, 1)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = self.containerView,
            let coordinator = presentedViewController.transitionCoordinator
            else { return }

        containerView.insertSubview(overlayView, at: 0)

        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:)))
        tap.cancelsTouchesInView = false
        containerView.addGestureRecognizer(tap)

        overlayView.alpha = 0
        coordinator.animate(alongsideTransition: { _ in
            self.overlayView.alpha = 1
        })

        presentedView?.layer.transform = presentedViewTransform

        UIView.animate(
            withDuration: item.options.durations.springPresent,
            delay: 0,
            usingSpringWithDamping: item.options.durations.springDamping,
            initialSpringVelocity: item.options.durations.springVelocity,
            animations: {
                self.presentedView?.layer.transform = CATransform3DIdentity
        })
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        contextDelegate?.willDismiss(presentationController: self)
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        coordinator.animate(alongsideTransition: { _ in
            self.presentedView?.layer.transform = self.presentedViewTransform
            self.overlayView.alpha = 0
        })
    }

    @objc func onTap(recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .ended,
            let containerView = self.containerView,
            presentedView?.frame.contains(recognizer.location(in: containerView)) == false
            else { return }
        presentingViewController.dismiss(animated: true)
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        guard let containerView = self.containerView else { return }
        UIView.animate(withDuration: item.options.durations.resize) {
            containerView.setNeedsLayout()
            containerView.layoutIfNeeded()
        }
    }

}
