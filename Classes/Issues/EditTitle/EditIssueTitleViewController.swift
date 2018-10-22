//
//  EditIssueTitleViewController.swift
//  Freetime
//
//  Created by B_Litwin on 10/22/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubAPI
import SnapKit

protocol EditIssueTitleViewControllerDelegate: class {
    func sendEditTitleRequest(newTitle: String, viewController: EditIssueTitleViewController)
    var currentIssueTitle: String? { get }
    var viewerCanUpdate: Bool { get }
}

class EditIssueTitleViewController: UIViewController {

    private let textView = UITextView()
    private let issueTitle: String
    private weak var delegate: EditIssueTitleViewControllerDelegate?
    
    init(delegate: EditIssueTitleViewControllerDelegate) {
        self.delegate = delegate
        self.issueTitle = delegate.currentIssueTitle ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(
            width: Styles.Sizes.contextMenuSize.width,
            height: 120
        )
        title = NSLocalizedString("Edit", comment: "")
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        textView.textContainerInset = Styles.Sizes.textViewInset
        textView.text = issueTitle
        
        setRightBarItemIdle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: Constants.Strings.cancel,
            style: .plain,
            target: self,
            action: #selector(
                EditIssueTitleViewController.onMenuCancel
            )
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    func setRightBarItemIdle() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Save", comment: ""),
            style: .plain,
            target: self,
            action: #selector(
                EditIssueTitleViewController.onMenuSave
            )
        )
    }
    
    @objc func onMenuSave() {
        textView.isEditable = false
        textView.resignFirstResponder()
        guard textView.text != issueTitle else { return }
        setRightBarItemSpinning()
        delegate?.sendEditTitleRequest(
            newTitle: textView.text,
            viewController: self
        )
    }
    
    @objc func onMenuCancel() {
        textView.resignFirstResponder()
        dismiss(animated: true)
    }
    
}
