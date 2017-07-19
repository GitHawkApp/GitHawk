//
//  SplitPlaceholderNavigationController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SplitPlaceholderViewController: UIViewController {

    private let imageView = UIImageView(image: UIImage(named: "splash-light"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Styles.Colors.background

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }

}
