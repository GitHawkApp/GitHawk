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

    func addBottomBorder(left: CGFloat = 0, right: CGFloat = 0) {
        let view = UIView()
        view.backgroundColor = Styles.Colors.Gray.border
        addSubview(view)
        view.snp.makeConstraints { make in
            make.height.equalTo(1.0 / UIScreen.main.scale)
            make.bottom.equalTo(self)
            make.left.equalTo(left)
            make.right.equalTo(right)
        }
    }

}
