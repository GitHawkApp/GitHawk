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
    private let codeTextView = CodeTextView()

    init(file: File, client: GithubClient) {
        self.file = file
        self.client = client
        super.init(nibName: nil, bundle: nil)

        title = file.filename

        let colorCodedString = CreateColorCodedString(code: file.patch, includeDiff: true)
        codeTextView.attributedText = colorCodedString

        view.addSubview(codeTextView)
        codeTextView.isEditable = false
        codeTextView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(codeTextView)
    }
}
