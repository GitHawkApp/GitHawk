//
//  UIControlEffects.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/1/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import Foundation

struct UIControlEffect {
    let backgroundColor: UIColor?
    let alpha: CGFloat
    let transform: CGAffineTransform
    let downDuration: TimeInterval
    let liftDuration: TimeInterval

    init(
        backgroundColor: UIColor? = nil,
        alpha: CGFloat = 0.6,
        transform: CGAffineTransform = CGAffineTransform(scaleX: 0.95, y: 0.95),
        downDuration: TimeInterval = 0.07,
        liftDuration: TimeInterval = 0.13
        ) {
        self.backgroundColor = backgroundColor
        self.alpha = alpha
        self.transform = transform
        self.downDuration = downDuration
        self.liftDuration = liftDuration
    }
}

fileprivate final class UIControlEffects: NSObject {

    struct State {
        let backgroundColor: UIColor?
        let alpha: CGFloat
        let transform: CGAffineTransform
    }

    let effect: UIControlEffect
    var savedState: State? = nil

    init(effect: UIControlEffect) {
        self.effect = effect
    }

    @objc func didTouchDown(_ control: UIControl) {
        // restore when lifted
        savedState = State(
            backgroundColor:
            control.backgroundColor,
            alpha: control.alpha,
            transform: control.transform
        )

        let effect = self.effect
        UIView.animate(withDuration: effect.downDuration) {
            if let backgroundColor = effect.backgroundColor {
                control.backgroundColor = backgroundColor
            }
            control.alpha = effect.alpha
            control.transform = effect.transform
        }
    }

    @objc func didLift(_ control: UIControl) {
        guard let savedState = self.savedState else { return }
        UIView.animate(withDuration: effect.liftDuration) {
            control.backgroundColor = savedState.backgroundColor
            control.alpha = savedState.alpha
            control.transform = savedState.transform
        }
    }

}

extension UIControl {

    private struct AssociatedKeys {
        static var Name = "com.freetime.uicontroleffects.key"
    }

    func add(touch effect: UIControlEffect) {
        let object = UIControlEffects(effect: effect)

        addTarget(object, action: #selector(object.didTouchDown), for: .touchDown)
        addTarget(object, action: #selector(object.didLift), for: .touchUpInside)
        addTarget(object, action: #selector(object.didLift), for: .touchUpOutside)

        // bind the effect object's lifecycle to the control
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.Name,
            object,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }

}
