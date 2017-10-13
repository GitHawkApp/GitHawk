//
//  WriteButton.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class WriteButton: UIView {

    let preferredSize = CGSize(width: 56, height: 56)

    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        button.setImage(UIImage(named: "write")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.accessibilityLabel = NSLocalizedString("Write a comment", comment: "")
        button.tintColor = .white
        button.clipsToBounds = true
        addSubview(button)

        // use UIButton's built-in mechanics for highlighting the background color
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            let color = Styles.Colors.Blue.medium.color.withAlphaComponent(0.97)
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
            button.setBackgroundImage(backgroundImage, for: .normal)
        }
        UIGraphicsEndImageContext()

        let cornerRadius = preferredSize.width/2
        button.layer.cornerRadius = cornerRadius

        layer.shadowPath = UIBezierPath(roundedRect: CGRect(origin: .zero, size: preferredSize), cornerRadius: cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = Styles.Sizes.gutter
        layer.shadowOpacity = 0.35
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
    }

    // MARK: Public API

    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        button.addTarget(target, action: action, for: controlEvents)
    }

}
