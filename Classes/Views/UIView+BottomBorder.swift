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

    @discardableResult
    func addBorder(bottom: Bool = true, left: CGFloat = 0, right: CGFloat = 0) -> UIView {
        let view = UIView()
        view.backgroundColor = Styles.Colors.Gray.border.color
        addSubview(view)
        view.snp.makeConstraints { make in
            make.height.equalTo(1.0 / UIScreen.main.scale)

            if bottom {
                make.bottom.equalTo(self)
            } else {
                make.top.equalTo(self)
            }

            make.left.equalTo(left)
            make.right.equalTo(right)
        }
        return view
    }

}
