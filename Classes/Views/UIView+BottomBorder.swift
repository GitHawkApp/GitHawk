//
//  UIView+BottomBorder.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {

    enum Position {
        case left
        case top
        case right
        case bottom
    }

    @discardableResult
    func addBorder(
        _ position: Position,
        left: CGFloat = 0,
        right: CGFloat = 0,
        top: CGFloat = 0,
        bottom: CGFloat = 0
        ) -> UIView {
        let view = UIView()
        view.backgroundColor = Styles.Colors.Gray.border.color
        addSubview(view)
        view.snp.makeConstraints { make in
            let size = 1.0 / UIScreen.main.scale

            switch position {
            case .top, .bottom:
                make.height.equalTo(size)
                make.left.equalTo(left)
                make.right .equalTo(right)
            case .left, .right:
                make.width.equalTo(size)
                make.top.equalTo(top)
                make.bottom.equalTo(bottom)
            }

            switch position {
            case .left: make.left.equalTo(self)
            case .top: make.top.equalTo(self)
            case .right: make.right.equalTo(self)
            case .bottom: make.bottom.equalTo(self)
            }
        }
        return view
    }

}
