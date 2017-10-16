//
//  RepositoryCodeBlobViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class RepositoryCodeBlobViewController: UIViewController, GutterLayoutManagerDelegate {

    private let client: GithubClient
    private let path: String
    private let repo: RepositoryDetails
    private let scrollView = UIScrollView()
    private let textView: UITextView = {
        let textContainer = GutterTextContainer()

        let layoutManager = GutterLayoutManager()
        layoutManager.showGutter = true
        layoutManager.showLineNumbers = true
        layoutManager.addTextContainer(textContainer)

        // storage implicitly required to use NSLayoutManager + NSTextContainer and find a size
        let textStorage = NSTextStorage()
        textStorage.addLayoutManager(layoutManager)

        return UITextView(frame: .zero, textContainer: textContainer)
    }()
    private let feedRefresh = FeedRefresh()
    private let emptyView = EmptyView()

    init(client: GithubClient, repo: RepositoryDetails, path: String) {
        self.client = client
        self.repo = repo
        self.path = path
        super.init(nibName: nil, bundle: nil)
        self.title = path
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        emptyView.isHidden = true
        view.addSubview(emptyView)

        scrollView.backgroundColor = .clear
        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)

        scrollView.refreshControl = feedRefresh.refreshControl
        feedRefresh.refreshControl.addTarget(self, action: #selector(RepositoryCodeBlobViewController.onRefresh), for: .valueChanged)

        if let layoutManager = textView.layoutManager as? GutterLayoutManager {
            layoutManager.gutterDelegate = self
        }

        textView.font = Styles.Fonts.code
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.contentInset = .zero
        textView.textContainerInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing,
            left: Styles.Sizes.columnSpacing,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.columnSpacing
        )
        scrollView.addSubview(textView)

        fetch()
        feedRefresh.beginRefreshing()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let bounds = view.bounds
        emptyView.frame = bounds
        scrollView.frame = bounds
    }

    // MARK: Private API

    @objc
    func onRefresh() {
        fetch()
    }

    func fetch() {
        client.fetchFile(owner: repo.owner, repo: repo.name, path: path) { [weak self] (result) in
            self?.feedRefresh.endRefreshing()
            switch result {
            case .success(let text):
                self?.handle(text: text)
            case .nonUTF8:
                self?.error(cannotLoad: true)
            case .error:
                self?.error(cannotLoad: false)
                ToastManager.showGenericError()
            }
        }
    }

    func error(cannotLoad: Bool) {
        emptyView.isHidden = false
        emptyView.label.text = cannotLoad
            ? NSLocalizedString("Cannot display file as text", comment: "")
            : NSLocalizedString("Error loading file", comment: "")
    }

    func handle(text: String) {
        emptyView.isHidden = true

        textView.attributedText = CreateColorCodedString(code: text, includeDiff: false, lineHandler: nil)
        let max = CGFloat.greatestFiniteMagnitude
        let size = textView.sizeThatFits(CGSize(width: max, height: max))
        textView.frame = CGRect(origin: .zero, size: size)
        scrollView.contentSize = size
    }

    // MARK: GutterLayoutManagerDelegate implementation

    func getMaximumGutterWidth(gutterLayoutManager: GutterLayoutManager) -> CGFloat {
        guard let textStorage = gutterLayoutManager.textStorage else { return 0 }
        let numberOfLines = textStorage.string.components(separatedBy: .newlines).count
        let maxLength = "\(numberOfLines)".count
        let fillerString = String(repeating: "9", count: maxLength)
        let maxGutterSize = (fillerString as NSString).size(withAttributes: [NSAttributedStringKey.font: gutterLayoutManager.gutterFont])
        return ceil(maxGutterSize.width)
    }
}
