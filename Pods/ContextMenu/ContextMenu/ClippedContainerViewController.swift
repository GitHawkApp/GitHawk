//
//  ClippedContainerViewController.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

class ClippedContainerViewController: UIViewController {

    let viewController: UIViewController

    private let options: ContextMenu.Options
    private let containedViewController: UINavigationController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewController.preferredStatusBarStyle
    }

    init(options: ContextMenu.Options, viewController: UIViewController) {
        self.viewController = viewController
        self.options = options
        self.containedViewController = UINavigationController(rootViewController: viewController)
        super.init(nibName: nil, bundle: nil)
        self.containedViewController.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = options.containerStyle.cornerRadius
        view.layer.shadowRadius = options.containerStyle.shadowRadius
        view.layer.shadowOpacity = options.containerStyle.shadowOpacity
        view.layer.shadowOffset = options.containerStyle.shadowOffset
        view.layer.shadowColor = UIColor.black.cgColor
        view.backgroundColor = options.containerStyle.backgroundColor

        if options.containerStyle.motionEffect && UIAccessibility.isReduceMotionEnabled == false {
            let amount = 12
            let tiltX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            tiltX.minimumRelativeValue = -amount
            tiltX.maximumRelativeValue = amount

            let tiltY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            tiltY.minimumRelativeValue = -amount
            tiltY.maximumRelativeValue = amount

            let group = UIMotionEffectGroup()
            group.motionEffects = [tiltX, tiltY]
            view.addMotionEffect(group)
        }

        containedViewController.view.layer.cornerRadius = view.layer.cornerRadius
        containedViewController.view.clipsToBounds = true
        containedViewController.setNavigationBarHidden(options.menuStyle == .minimal, animated: false)

        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }

        options.containerStyle.backgroundColor.setFill()
        UIBezierPath(rect: CGRect(origin: .zero, size: size)).fill()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        let navigationBar = containedViewController.navigationBar
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(image, for: .any, barMetrics: .default)
        navigationBar.shadowImage = image

        addChild(containedViewController)
        view.addSubview(containedViewController.view)
        containedViewController.didMove(toParent: self)

        preferredContentSize = containedViewController.preferredContentSize
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        containedViewController.view.frame = view.bounds
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        preferredContentSize = container.preferredContentSize
    }

}

extension ClippedContainerViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.view.backgroundColor = options.containerStyle.backgroundColor
    }

}
