//
//  IssuePatchContentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledTextKit

final class IssuePatchContentViewController: UIViewController {

    private let patch: String
    private let codeView = CodeView()

    init(patch: String, fileName: String) {
        self.patch = patch
        super.init(nibName: nil, bundle: nil)
        title = fileName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(codeView)
        codeView.set(
            attributedCode: CreateDiffString(code: patch)
                .render(contentSizeCategory: UIApplication.shared.preferredContentSizeCategory)
        )
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        codeView.frame = view.safeAreaLayoutGuide.layoutFrame
    }

}
