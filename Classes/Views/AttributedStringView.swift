//
//  AttributedStringView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol AttributedStringViewDelegate: class {
    func didTapURL(view: AttributedStringView, url: URL)
    func didTapUsername(view: AttributedStringView, username: String)
    func didTapEmail(view: AttributedStringView, email: String)
    func didTapCommit(view: AttributedStringView, commit: CommitDetails)
    func didTapLabel(view: AttributedStringView, label: LabelDetails)
}

protocol AttributedStringViewIssueDelegate: class {
    func didTapIssue(view: AttributedStringView, issue: IssueDetailsModel)
}

final class AttributedStringView: UIView {

    weak var delegate: AttributedStringViewDelegate?
    weak var issueDelegate: AttributedStringViewIssueDelegate?

    private var text: NSAttributedStringSizing?
    private var tapGesture: UITapGestureRecognizer?
    private var longPressGesture: UILongPressGestureRecognizer?

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        isOpaque = true

        layer.contentsGravity = kCAGravityTopLeft

        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:)))
        addGestureRecognizer(tap)
        self.tapGesture = tap

        let long = UILongPressGestureRecognizer(target: self, action: #selector(onLong(recognizer:)))
        addGestureRecognizer(long)
        self.longPressGesture = long
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: UIGestureRecognizerDelegate

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard (gestureRecognizer === tapGesture || gestureRecognizer === longPressGesture),
            let attributes = text?.attributes(point: gestureRecognizer.location(in: self)) else {
                return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        for attribute in attributes {
            if MarkdownAttribute.all.contains(attribute.key) {
                return true
            }
        }
        return false
    }

    // MARK: Accessibility

    override var accessibilityLabel: String? {
        get {
            return text?.attributedText.string
        }
        set { }
    }

    // MARK: Public API

    func reposition(width: CGFloat) {
        guard let text = text else { return }
        layer.contents = text.contents(width)
        let rect = CGRect(origin: .zero, size: text.textViewSize(width))
        frame = UIEdgeInsetsInsetRect(rect, text.inset)
    }

    func configureAndSizeToFit(text: NSAttributedStringSizing, width: CGFloat) {
        self.text = text
        layer.contentsScale = text.screenScale
        reposition(width: width)
    }

    // MARK: Private API

    @objc func onTap(recognizer: UITapGestureRecognizer) {
        guard let attributes = text?.attributes(point: recognizer.location(in: self)) else { return }
        if let urlString = attributes[MarkdownAttribute.url] as? String, let url = URL(string: urlString) {
            delegate?.didTapURL(view: self, url: url)
        } else if let usernameString = attributes[MarkdownAttribute.username] as? String {
            delegate?.didTapUsername(view: self, username: usernameString)
        } else if let emailString = attributes[MarkdownAttribute.email] as? String {
            delegate?.didTapEmail(view: self, email: emailString)
        } else if let issue = attributes[MarkdownAttribute.issue] as? IssueDetailsModel {
            issueDelegate?.didTapIssue(view: self, issue: issue)
        } else if let label = attributes[MarkdownAttribute.label] as? LabelDetails {
            delegate?.didTapLabel(view: self, label: label)
        } else if let commit = attributes[MarkdownAttribute.commit] as? CommitDetails {
            delegate?.didTapCommit(view: self, commit: commit)
        }
    }

    @objc func onLong(recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began else { return }

        let point = recognizer.location(in: self)
        guard let attributes = text?.attributes(point: point) else { return }
        if let details = attributes[MarkdownAttribute.details] as? String {
            showDetailsInMenu(details: details, point: point)
        }
    }

    @objc func showDetailsInMenu(details: String, point: CGPoint) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        menu.menuItems = [
            UIMenuItem(title: details, action: #selector(AttributedStringView.empty))
        ]
        menu.setTargetRect(CGRect(origin: point, size: CGSize(width: 1, height: 1)), in: self)
        menu.setMenuVisible(true, animated: trueUnlessReduceMotionEnabled)
    }

    @objc func empty() {}

}
