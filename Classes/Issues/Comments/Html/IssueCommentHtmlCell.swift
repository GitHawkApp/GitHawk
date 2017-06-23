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

    private static let htmlHead = [
        "<html><head><style>",
        "body{",
        // html whitelist: https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/sanitization_filter.rb#L45-L49
        "font-family: -apple-system; font-size: \(Styles.Sizes.Text.body)px;",
        "color: #\(Styles.Colors.Gray.dark);",
        "padding: \(Styles.Sizes.columnSpacing)px \(Styles.Sizes.gutter)px 0px;",
        "}",
        "b, strong{font-weight: 600;}",
        "i, em{font-style: italic;}",
        "a{color: #\(Styles.Colors.Blue.medium); text-decoration: none;}",
        "h1{font-size: \(Styles.Sizes.Text.h1);}",
        "h2{font-size: \(Styles.Sizes.Text.h2);}",
        "h3{font-size: \(Styles.Sizes.Text.h3);}",
        "h4{font-size: \(Styles.Sizes.Text.h4);}",
        "h5{font-size: \(Styles.Sizes.Text.h5);}",
        "h6, h7, h8{font-size: \(Styles.Sizes.Text.h6), color: #\(Styles.Colors.Gray.medium);}",
        "dl dt{margin-top: 16px; font-style: italic; font-weight: 600;}",
        "dl dd{padding: 0 16px;}",
        "blockquote{font-style: italic; color: #\(Styles.Colors.Gray.medium);}",
        "pre, code{background-color: #\(Styles.Colors.Gray.lighter);}",
        "pre{padding: \(Styles.Sizes.columnSpacing)px \(Styles.Sizes.gutter)px;}",
        "</style></head><body>",
        ].joined(separator: "")
    private static let htmlTail = "</body></html>"

    weak var delegate: IssueCommentHtmlCellDelegate? = nil

    private let webView = UIWebView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        webView.delegate = self

        let scrollView = webView.scrollView
        scrollView.scrollsToTop = false

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
        let html = IssueCommentHtmlCell.htmlHead + viewModel.html + IssueCommentHtmlCell.htmlTail
        webView.loadHTMLString(html, baseURL: nil)
    }

    // MARK: UIWebViewDelegate

    func webViewDidFinishLoad(_ webView: UIWebView) {
        delegate?.webViewDidLoad(cell: self)
    }

}
