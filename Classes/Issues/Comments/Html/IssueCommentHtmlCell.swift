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
    func webViewDidResize(cell: IssueCommentHtmlCell, html: String, cellWidth: CGFloat, size: CGSize)
}

protocol IssueCommentHtmlCellNavigationDelegate: class {
    func webViewWantsNavigate(cell: IssueCommentHtmlCell, url: URL)
}

private final class IssueCommentHtmlCellWebView: UIWebView {

    override var safeAreaInsets: UIEdgeInsets {
        return .zero
    }

}

final class IssueCommentHtmlCell: DoubleTappableCell, ListBindable, UIWebViewDelegate {

    private static let WebviewKeyPath = #keyPath(UIWebView.scrollView.contentSize)

    private static let htmlHead = """
    <!DOCTYPE html><html><head><style>
    body{
    // html whitelist: https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/sanitization_filter.rb#L45-L49
    // lint compiled style with http://csslint.net/
    font-family: -apple-system; font-size: \(Styles.Sizes.Text.body)px;
    color: #\(Styles.Colors.Gray.dark);
    padding: \(Styles.Sizes.columnSpacing)px \(Styles.Sizes.gutter)px 0;
    margin: 0;
    }
    b, strong{font-weight: \(Styles.Sizes.HTML.boldWeight);}
    i, em{font-style: italic;}
    a{color: #\(Styles.Colors.Blue.medium); text-decoration: none;}
    h1{font-size: \(Styles.Sizes.Text.h1);}
    h2{font-size: \(Styles.Sizes.Text.h2);}
    h3{font-size: \(Styles.Sizes.Text.h3);}
    h4{font-size: \(Styles.Sizes.Text.h4);}
    h5{font-size: \(Styles.Sizes.Text.h5);}
    h6, h7, h8{font-size: \(Styles.Sizes.Text.h6)px; color: #\(Styles.Colors.Gray.medium);}
    dl dt{margin-top: \(Styles.Sizes.HTML.spacing)px; font-style: italic; font-weight: \(Styles.Sizes.HTML.boldWeight);}
    dl dd{padding: 0 \(Styles.Sizes.HTML.spacing)px;}
    blockquote{font-style: italic; color: #\(Styles.Colors.Gray.medium);}
    pre, code{background-color: #\(Styles.Colors.Gray.lighter); font-family: Courier;}
    pre{padding: \(Styles.Sizes.columnSpacing)px \(Styles.Sizes.gutter)px;}
    sub{font-family: -apple-system;}
    table{border-spacing: 0; border-collapse: collapse;}
    th, td{border: 1px solid #\(Styles.Colors.Gray.border); padding: 6px 13px;}
    th{font-weight: \(Styles.Sizes.HTML.boldWeight); text-align: center;}
    img{max-width:100%; box-sizing: border-box;}
    </style>
    </head><body>
    """
    private static let htmlTail = """
    <script>
        document.documentElement.style.webkitUserSelect='none';
        document.documentElement.style.webkitTouchCallout='none';
    </script>
    </body>
    </html>
    """

    weak var delegate: IssueCommentHtmlCellDelegate?
    weak var navigationDelegate: IssueCommentHtmlCellNavigationDelegate?

    @objc private let webView = IssueCommentHtmlCellWebView()
    private var body = ""
    var webViewBaseURL: URL?

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        webView.backgroundColor = .white
        webView.delegate = self
        webView.addObserver(self, forKeyPath: IssueCommentHtmlCell.WebviewKeyPath, options: [.new], context: nil)

        let scrollView = webView.scrollView
        scrollView.scrollsToTop = false
        scrollView.bounces = true

        contentView.addSubview(webView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        webView.removeObserver(self, forKeyPath: IssueCommentHtmlCell.WebviewKeyPath)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        webView.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        if webView.frame != contentView.bounds {
            webView.frame = contentView.bounds
        }
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentHtmlModel else { return }
        body = viewModel.html
        webViewBaseURL = viewModel.baseURL

        let html = IssueCommentHtmlCell.htmlHead + body + IssueCommentHtmlCell.htmlTail
        webView.loadHTMLString(html, baseURL: webViewBaseURL)
    }

    // MARK: UIWebViewDelegate

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else { return true }

        if let baseURL = webViewBaseURL, url == baseURL {
            return true
        }

        let htmlLoad = url.absoluteString == "about:blank"
        if !htmlLoad {
            navigationDelegate?.webViewWantsNavigate(cell: self, url: url)
        }
        return htmlLoad
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.isHidden = false
    }

    // MARK: KVO

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == IssueCommentHtmlCell.WebviewKeyPath {
            delegate?.webViewDidResize(
                cell: self,
                html: body,
                cellWidth: contentView.bounds.width,
                size: webView.scrollView.contentSize
            )
        }
    }

}
