//
//  IndicatorView.swift
//  MailExample
//
//  Created by Ryan Nystrom on 6/26/17.
//
//

import UIKit

class IndicatorView: UIView {
    var color = UIColor.clear {
        didSet { setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {
        color.set()
        UIBezierPath(ovalIn: rect).fill()
    }
}
