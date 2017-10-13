//
//  Toast.swift
//  Toast
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

struct ToastViewConfiguration {
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

final class ToastView: UIView {

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

final class ToastManager {

    private final class ToastDynamicItem: NSObject, UIDynamicItem {
        var center: CGPoint = .zero
        var bounds: CGRect { return CGRect(x: 0, y: 0, width: 1, height: 1) }
        var transform: CGAffineTransform = .identity
    }

    private let dynamicItem = ToastDynamicItem()
    public var view: ToastView? = nil
    private lazy var animator: UIDynamicAnimator? = nil
    private var springBehavior: UIAttachmentBehavior? = nil
    private var config: ToastViewConfiguration? = nil
    private var timer: Timer? = nil

    // MARK: Public API

    public static let shared = ToastManager()

    public func show(
        viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController,
        config: ToastViewConfiguration
        ) {
        guard let viewController = viewController,
            let referenceView = viewController.view
            else { return }

        self.config = config
        startTimer()

        if let view = self.view {
            view.removeFromSuperview()
        }

        let view = ToastView(configuration: config)
        view.frame = CGRect(origin: .zero, size: view.contentSize())
        self.view = view

        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(ToastManager.onPan(gesture:))))

        referenceView.addSubview(view)

        self.animator = UIDynamicAnimator(referenceView: referenceView)

        let bounds = referenceView.bounds
        let tabBarHeight: CGFloat = 49

        let safeAreaInsets: CGFloat
        if #available(iOS 11.0, *) {
            safeAreaInsets = referenceView.safeAreaInsets.bottom + viewController.additionalSafeAreaInsets.bottom
        } else {
            safeAreaInsets = 0
        }

        let anchor = CGPoint(
            x: bounds.width / 2,
            y: bounds.height - tabBarHeight - safeAreaInsets - view.bounds.height / 2 - 20
        )

        // position off screen so it snaps in
        view.center = anchor.applying(CGAffineTransform(translationX: 0, y: bounds.height - anchor.y + 500))

        let springBehavior = UIAttachmentBehavior(item: view, attachedToAnchor: anchor)
        springBehavior.length = 0
        springBehavior.damping = 0.8
        springBehavior.frequency = 1.5
        self.animator?.addBehavior(springBehavior)
        self.springBehavior = springBehavior
    }

    @objc func onPan(gesture: UIPanGestureRecognizer) {
        guard let referenceView = self.animator?.referenceView,
            let springBehavior = self.springBehavior,
            let view = self.view
            else { return }

        switch gesture.state {
        case .began:
            timer?.invalidate()
            animator?.removeBehavior(springBehavior)
        case .changed:
            let anchor = springBehavior.anchorPoint
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
            view.center = CGPoint(
                x: anchor.x,
                y: y + anchor.y
            )
        case .ended, .cancelled, .failed:
            let velocity = gesture.velocity(in: referenceView).y

            // if the final destination is beyond the ref view height after 0.3 seconds...
            let duration: TimeInterval = 0.3
            let finalY = velocity * CGFloat(duration) + view.center.y
            if finalY - view.bounds.height / 2 > referenceView.bounds.height {
                UIView.animate(withDuration: duration, animations: {
                    var center = view.center
                    center.y = finalY
                    view.center = center
                })
            } else {
                startTimer()
                animator?.addBehavior(springBehavior)
            }
        default: break
        }
    }

    func startTimer() {
        guard let config = self.config else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: config.dismissDuration,
            repeats: false,
            block: { [weak self] (_) in
                self?.dismiss()
        })
    }

    func dismiss() {
        guard let referenceView = self.animator?.referenceView,
            let springBehavior = self.springBehavior,
            let view = self.view
            else { return }
        var center = springBehavior.anchorPoint
        center.y = referenceView.bounds.height + view.bounds.height / 2 + 100
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            view.alpha = 0
            view.center = center
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }

}


