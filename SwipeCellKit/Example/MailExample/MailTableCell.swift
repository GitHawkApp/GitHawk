//
//  MailTableCell.swift
//  MailExample
//
//  Created by Ryan Nystrom on 6/26/17.
//
//

import UIKit
import SwipeCellKit

class MailTableCell: SwipeTableViewCell {
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!

    var animator: Any?

    var indicatorView = IndicatorView(frame: .zero)

    var unread = false {
        didSet {
            indicatorView.transform = unread ? CGAffineTransform.identity : CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        }
    }

    override func awakeFromNib() {
        setupIndicatorView()
    }

    func setupIndicatorView() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = tintColor
        indicatorView.backgroundColor = .clear
        contentView.addSubview(indicatorView)

        let size: CGFloat = 12
        indicatorView.widthAnchor.constraint(equalToConstant: size).isActive = true
        indicatorView.heightAnchor.constraint(equalTo: indicatorView.widthAnchor).isActive = true
        indicatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: fromLabel.centerYAnchor).isActive = true
    }

    func setUnread(_ unread: Bool, animated: Bool) {
        let closure = {
            self.unread = unread
        }

        if #available(iOS 10, *), animated {
            var localAnimator = self.animator as? UIViewPropertyAnimator
            localAnimator?.stopAnimation(true)

            localAnimator = unread ? UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.4) : UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1.0)
            localAnimator?.addAnimations(closure)
            localAnimator?.startAnimation()

            self.animator = localAnimator
        } else {
            closure()
        }
    }
}
