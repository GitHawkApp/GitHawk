//
//  ViewMarkdownViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class ViewMarkdownViewController: UIViewController {

    private let markdown: String
    private let textView = UITextView()

    init(markdown: String) {
        self.markdown = markdown
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Markdown", comment: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(onDismiss)
        )

        textView.isEditable = false
        textView.text = markdown
        textView.font = Styles.Text.code.preferredFont
        textView.textColor = Styles.Colors.Gray.dark.color
        textView.textContainerInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing,
            left: Styles.Sizes.rowSpacing,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.rowSpacing
        )
        view.addSubview(textView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textView.frame = view.bounds
    }

    // MARK: Private API

    @objc func onDismiss() {
        dismiss(animated: trueUnlessReduceMotionEnabled)
    }

}
