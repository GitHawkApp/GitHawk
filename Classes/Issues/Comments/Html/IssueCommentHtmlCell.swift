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
    func webViewDidLoad(cell: IssueCommentHtmlCell, html: String)
}

protocol IssueCommentHtmlCellNavigationDelegate: class {
    func webViewWantsNavigate(cell: IssueCommentHtmlCell, url: URL)
}

final class IssueCommentHtmlCell: UICollectionViewCell, ListBindable, UIWebViewDelegate {

    private static let htmlHead = [
        "<!DOCTYPE html><html><head><style>",
        "body{",
        // html whitelist: https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/sanitization_filter.rb#L45-L49
        // lint compiled style with http://csslint.net/
        "font-family: -apple-system; font-size: \(Styles.Sizes.Text.body)px;",
        "color: #\(Styles.Colors.Gray.dark);",
        "padding: \(Styles.Sizes.columnSpacing)px \(Styles.Sizes.gutter)px 0;",
        "}",
        "b, strong{font-weight: \(Styles.Sizes.HTML.boldWeight);}",
        "i, em{font-style: italic;}",
        "a{color: #\(Styles.Colors.Blue.medium); text-decoration: none;}",
        "h1{font-size: \(Styles.Sizes.Text.h1);}",
        "h2{font-size: \(Styles.Sizes.Text.h2);}",
        "h3{font-size: \(Styles.Sizes.Text.h3);}",
        "h4{font-size: \(Styles.Sizes.Text.h4);}",
        "h5{font-size: \(Styles.Sizes.Text.h5);}",
        "h6, h7, h8{font-size: \(Styles.Sizes.Text.h6)px; color: #\(Styles.Colors.Gray.medium);}",
        "dl dt{margin-top: \(Styles.Sizes.HTML.spacing)px; font-style: italic; font-weight: \(Styles.Sizes.HTML.boldWeight);}",
        "dl dd{padding: 0 \(Styles.Sizes.HTML.spacing)px;}",
        "blockquote{font-style: italic; color: #\(Styles.Colors.Gray.medium);}",
        "pre, code{background-color: #\(Styles.Colors.Gray.lighter); font-family: Courier;}",
        "pre{padding: \(Styles.Sizes.columnSpacing)px \(Styles.Sizes.gutter)px;}",
        "table{border-spacing: 0; border-collapse: collapse;}",
        "th, td{border: 1px solid #\(Styles.Colors.Gray.border); padding: 6px 13px;}",
        "th{font-weight: \(Styles.Sizes.HTML.boldWeight); text-align: center;}",
        "</style></head><body>",
        ].joined(separator: "")
    private static let htmlTail = "</body></html>"

    weak var delegate: IssueCommentHtmlCellDelegate? = nil
    weak var navigationDelegate: IssueCommentHtmlCellNavigationDelegate? = nil

    private let webView = UIWebView()
    private var body = ""

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        webView.backgroundColor = .white
        webView.delegate = self

        let scrollView = webView.scrollView
        scrollView.scrollsToTop = false
        scrollView.bounces = true

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
        body = viewModel.html
        let html = IssueCommentHtmlCell.htmlHead + body + IssueCommentHtmlCell.htmlTail
        webView.loadHTMLString(html, baseURL: nil)
    }

    // MARK: UIWebViewDelegate

    func webViewDidFinishLoad(_ webView: UIWebView) {
        delegate?.webViewDidLoad(cell: self, html: body)
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else { return true }
        let htmlLoad = url.absoluteString == "about:blank"
        if !htmlLoad {
            navigationDelegate?.webViewWantsNavigate(cell: self, url: url)
        }
        return htmlLoad
    }

}
