//
//  IssueCommentHtmlCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol IssueCommentHtmlCellDelegate: class {
    func webViewDidLoad(cell: IssueCommentHtmlCell)
}

final class IssueCommentHtmlCell: UICollectionViewCell, ListBindable, UIWebViewDelegate {

    weak var delegate: IssueCommentHtmlCellDelegate? = nil

    private let webView = UIWebView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.scrollsToTop = false
        contentView.addSubview(webView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        webView.frame = contentView.bounds
    }

    // MARK: Public API

    func webViewPreferredSize() -> CGSize {
        // https://stackoverflow.com/a/28746407/940936
        var frame = webView.frame
        frame.size.height = 1
        webView.frame = frame
        return webView.sizeThatFits(.zero)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentHtmlModel else { return }
        webView.loadHTMLString(viewModel.html, baseURL: nil)
    }

    // MARK: UIWebViewDelegate

    func webViewDidFinishLoad(_ webView: UIWebView) {
        delegate?.webViewDidLoad(cell: self)
    }

}
