//
//  IssuePatchContentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssuePatchContentViewController: UIViewController {

    private let file: File
    private let client: GithubClient
    private let scrollView = UIScrollView()
    private let attributeView = AttributedStringView()

    init(file: File, client: GithubClient) {
        self.file = file
        self.client = client
        super.init(nibName: nil, bundle: nil)

        title = file.actualFileName

        let width: CGFloat = 0
        let text = NSAttributedStringSizing(
            containerWidth: width,
            attributedText: CreateDiffString(code: file.patch),
            inset: Styles.Sizes.textViewInset
        )
        scrollView.contentSize = text.textViewSize(width)
        attributeView.configureAndSizeToFit(text: text, width: width)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)

        scrollView.addSubview(attributeView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
    }
    
}
