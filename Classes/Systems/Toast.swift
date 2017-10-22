//
//  Toast.swift
//  Toast
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public struct ToastViewConfiguration {
    let text: String
    let backgroundColor: UIColor
    let insets: UIEdgeInsets
    let maxWidth: CGFloat
    let buttonVisible: Bool
    let buttonLeftMargin: CGFloat
    let hintTopMargin: CGFloat
    let hintSize: CGSize
    let cornerRadius: CGFloat
    let borderColor: UIColor
    let dismissDuration: TimeInterval
}

protocol ToastViewDelegate: class {}

private final class ToastView: UIView {

    weak var delegate: ToastViewDelegate? = nil

    private let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    private let label = UILabel()
    private let button = UIButton(type: UIButtonType.infoLight)
    private let hintView = UIView()

    // MARK: Public API

    init(configuration: ToastViewConfiguration) {
        super.init(frame: .zero)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)

        backgroundView.backgroundColor = configuration.backgroundColor
        backgroundView.layer.cornerRadius = configuration.cornerRadius
        backgroundView.layer.borderColor = configuration.borderColor.cgColor
        backgroundView.layer.borderWidth = 1.0 / UIScreen.main.nativeScale
        backgroundView.clipsToBounds = true

        let contentView = backgroundView.contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0
        label.textColor = .white
        label.text = configuration.text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        contentView.addSubview(label)

        if configuration.buttonVisible {
            button.tintColor = .white
            button.addTarget(self, action: #selector(ToastView.onButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)

            addConstraint(NSLayoutConstraint(
                item: button,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: label,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            ))
        }

        hintView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        hintView.layer.cornerRadius = configuration.hintSize.height / 2
        hintView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hintView)

        // center the hint beneath the label
        addConstraint(NSLayoutConstraint(
            item: hintView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: configuration.hintSize.width
        ))
        addConstraint(NSLayoutConstraint(
            item: hintView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        ))

        let subviews: [String: UIView] = [
            "button": button,
            "label": label,
            "hintView": hintView,
            "contentView": contentView,
            ]

        if configuration.buttonVisible {
            let labelWidth = configuration.maxWidth - configuration.buttonLeftMargin - configuration.insets.left - configuration.insets.right
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-\(configuration.insets.left)-[label(<=\(labelWidth))]-\(configuration.buttonLeftMargin)-[button]-\(configuration.insets.right)-|",
                options: [],
                metrics: nil,
                views: subviews
            ))
        } else {
            let labelWidth = configuration.maxWidth - configuration.insets.left - configuration.insets.right
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-\(configuration.insets.left)-[label(<=\(labelWidth))]-\(configuration.insets.right)-|",
                options: [],
                metrics: nil,
                views: subviews
            ))
        }

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-\(configuration.insets.top)-[label]-\(configuration.hintTopMargin)-[hintView(\(configuration.hintSize.height))]-\(configuration.insets.bottom)-|",
            options: [],
            metrics: nil,
            views: subviews
        ))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[contentView]|",
            options: [],
            metrics: nil,
            views: subviews
        ))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[contentView]|",
            options: [],
            metrics: nil,
            views: subviews
        ))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = bounds
    }

    func contentSize() -> CGSize {
        backgroundView.updateConstraintsIfNeeded()
        backgroundView.layoutIfNeeded()
        return backgroundView.contentView.bounds.size
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private API

    @objc func onButton() {

    }

}

private func rubberBandDistance(offset: CGFloat, dimension: CGFloat) -> CGFloat {
    let constant: CGFloat = 0.55
    let absOffset = abs(offset)
    let result = (constant * absOffset * dimension) / (dimension + constant * absOffset)
    return offset < 0 ? -result : result
}

private func anchor(view: UIView, referenceView: UIView) -> CGPoint {
    let safeBottom: CGFloat
    if #available(iOS 11.0, *) {
        safeBottom = referenceView.safeAreaInsets.bottom
    } else {
        safeBottom = 0
    }

    let bounds = referenceView.bounds
    let tabBarHeight: CGFloat = 49
    return CGPoint(
        x: bounds.width / 2,
        y: bounds.height - tabBarHeight - safeBottom - view.bounds.height / 2 - 20
    )
}

final class ToastManager {

    private final class Toast {
        let view: ToastView
        let animator: UIDynamicAnimator
        let springBehavior: UIAttachmentBehavior
        let configuration: ToastViewConfiguration

        private var timer: Timer? = nil

        init?(config: ToastViewConfiguration, in baseView: UIView) {
            configuration = config

            view = ToastView(configuration: config)
            view.frame = CGRect(origin: .zero, size: view.contentSize())
            baseView.addSubview(view)

            animator = UIDynamicAnimator(referenceView: baseView)

            let initAnchor = anchor(view: view, referenceView: baseView)

            // position off screen so it snaps in. must happen before setting up spring
            view.center = initAnchor.applying(CGAffineTransform(
                translationX: 0,
                y: baseView.bounds.height - initAnchor.y + 500
            ))

            springBehavior = UIAttachmentBehavior(item: view, attachedToAnchor: initAnchor)
            springBehavior.length = 0
            springBehavior.damping = 0.8
            springBehavior.frequency = 1.5
            animator.addBehavior(springBehavior)
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

        func dismiss() {
            invalidateTimer()
            animator.removeBehavior(springBehavior)

            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                self.view.alpha = 0
                self.view.center = self.dismissAnchor
            }, completion: { _ in
                self.view.removeFromSuperview()
            })
        }

        func recenter() {
            // UIDynamics will throw if adding the behavior back when the view has already been removed
            guard view.superview != nil,
                let referenceView = animator.referenceView
                else { return }

            // hack to work around UI bug where behavior will permanently oscillate
            animator.removeBehavior(springBehavior)
            springBehavior.anchorPoint = anchor(view: view, referenceView: referenceView)
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

    }

    private var toast: Toast? = nil

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ToastManager.onOrientation(notification:)),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil
        )
    }

    // MARK: Public API

    public static let shared = ToastManager()

    public func show(
        in view: UIView? = UIApplication.shared.keyWindow,
        config: ToastViewConfiguration
        ) {
        guard let baseView = view else { return }

        // get rid of any view if currently displaying
        toast?.dismiss()

        toast = Toast(config: config, in: baseView)
        toast?.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(ToastManager.onPan(gesture:))))
        toast?.startTimer()
    }

    // MARK: Private API

    @objc func onPan(gesture: UIPanGestureRecognizer) {
        guard let toast = self.toast,
            let referenceView = toast.animator.referenceView
            else { return }

        switch gesture.state {
        case .began:
            toast.invalidateTimer()
            toast.animator.removeBehavior(toast.springBehavior)
        case .changed:
            let anchor = toast.springBehavior.anchorPoint
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
            toast.view.center = CGPoint(
                x: anchor.x,
                y: y + anchor.y
            )
        case .ended, .cancelled, .failed:
            let velocity = gesture.velocity(in: referenceView).y

            // if the final destination is beyond the ref view height after 0.3 seconds...
            let duration: TimeInterval = 0.3
            let finalY = velocity * CGFloat(duration) + toast.view.center.y
            if finalY - toast.view.bounds.height / 2 > referenceView.bounds.height {
                UIView.animate(withDuration: duration, animations: {
                    var center = toast.view.center
                    center.y = finalY
                    toast.view.center = center
                }) { _ in
                    toast.view.removeFromSuperview()
                }
            } else {
                toast.startTimer()
                toast.animator.addBehavior(toast.springBehavior)
            }
        default: break
        }
    }

    @objc func onOrientation(notification: NSNotification) {
        toast?.recenter()
    }

}


