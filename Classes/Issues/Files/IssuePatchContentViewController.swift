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
    private let codeView = CodeView()

    init(file: File, client: GithubClient) {
        self.file = file
        self.client = client
        super.init(nibName: nil, bundle: nil)
        title = file.actualFileName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(codeView)
        codeView.set(attributedCode: CreateDiffString(code: file.patch))
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        codeView.frame = view.bounds
    }

}
