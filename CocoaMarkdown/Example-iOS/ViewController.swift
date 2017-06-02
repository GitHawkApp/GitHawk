//
//  ViewController.swift
//  Example-iOS
//
//  Created by Indragie on 1/15/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit
import CocoaMarkdown

class ViewController: UIViewController {
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("test", ofType: "md")!
        let document = CMDocument(contentsOfFile: path, options: CMDocumentOptions(rawValue: 0))
        let renderer = CMAttributedStringRenderer(document: document, attributes: CMTextAttributes())
        renderer.registerHTMLElementTransformer(CMHTMLStrikethroughTransformer())
        renderer.registerHTMLElementTransformer(CMHTMLSuperscriptTransformer())
        renderer.registerHTMLElementTransformer(CMHTMLUnderlineTransformer())
        textView.attributedText = renderer.render()
    }
}

